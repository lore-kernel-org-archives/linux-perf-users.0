Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E108A1ACEDF;
	Thu, 23 Apr 2026 22:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776983795; cv=none; b=bLJGXm+tDY1tG7vUtlcQwaTPkwPu+k8uM1qrdENUcbLNUxe6PgqfY/iz54RdGRPeAwvKYhTh1cKjkM6I3Ja3rLWj/AtK9ESFHLVzr7WCjOG+Yex/X0oFqNRhCCuGecA8x7uiNTuAoa+ClXn0vTDjDs4/Or++H+JtCT+xwvveQZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776983795; c=relaxed/simple;
	bh=zwKqxsU235qut8eY8vpfS9vY/tKvp6P+DbH4/1TZTUU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t4C+aCfUj6gllYQ1YO4aVr4XJuHruI+PgWjk4GgzpybNZhsip6/rvpWfRFzxGloWj+r50jEVC6KrctOAr4vSM/5xWBVosz/ASkfo0mx6cDr3PW4sr+ZqWwyQY7JJxYbEdyb+34LUS/ESfa0Gf/JC12oK8XswFBut580qV00ER8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLPAFlh5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLPAFlh5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A071EC2BCAF;
	Thu, 23 Apr 2026 22:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776983794;
	bh=zwKqxsU235qut8eY8vpfS9vY/tKvp6P+DbH4/1TZTUU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=oLPAFlh5Ss1OQrVTsO31+uEvpUuIhIr/F+bGa5bAjAM2byQnzR3axFJQAweb36Jzv
	 AI8yljhO4Z/wDwDC+Ixjz7zvW4wBslRU8F1MpyD3hUnee1lXG6zAPh5p07LESJ1kQK
	 vNOE55VouKZHAnWRISiG7IKkB3AsyeF7ndOqPP0drRITuDvfvmCi3RuQJESFxBafI8
	 IQtZaP8S764/2CIrNnBOTMuJIvnKJIh58YW28rW5ylz40yJjEMjtq9GS/vr+zDkSAg
	 HwOmtOvjYYLhtwW9f1nwlihJ3IROS9OcT+24BZ4hlLCDlF046z4Q4CvM5L4bxza4Dk
	 xD+W1t4Yj8F1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf/lock: enable end-timestamp accounting for
 cgroup aggregation
Reply-To: sashiko@lists.linux.dev
To: "Suchit Karunakaran" <suchitkarunakaran@gmail.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260423173505.73223-1-suchitkarunakaran@gmail.com>
References: <20260423173505.73223-1-suchitkarunakaran@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 22:36:34 +0000
Message-Id: <20260423223634.A071EC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Incomplete spinlock and rwlock contentions are silently dropped =
under cgroup aggregation because of a leftover early return.
--

commit 5bccbbefb61cd7effb0fec5a7f0bee5add3ba114
Author: Suchit Karunakaran <suchitkarunakaran@gmail.com>

perf/lock: enable end-timestamp accounting for cgroup aggregation
   =20
This commit adds a cgroup_id field to struct tstamp_data, recording it at
contention_begin for cgroup aggregation mode. It also updates update_lock_s=
tat()
to use this recorded cgroup_id, enabling accounting for incomplete contenti=
ons
that start but never reach a contention_end event.

> diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_=
lock_contention.c
> index cbd7435579feaf..1a5bd2ff8ee4c2 100644
> --- a/tools/perf/util/bpf_lock_contention.c
> +++ b/tools/perf/util/bpf_lock_contention.c
> @@ -463,8 +463,8 @@ static void update_lock_stat(int map_fd, int pid, u64=
 end_ts,
>  		stat_key.lock_addr_or_cgroup =3D ts_data->lock;
>  		break;
>  	case LOCK_AGGR_CGROUP:
> -		/* TODO */
> -		return;
> +		stat_key.lock_addr_or_cgroup =3D ts_data->cgroup_id;
> +		break;
>  	default:
>  		return;
>  	}

Now that update_lock_stat() handles cgroup aggregation, does
account_end_timestamp() also need an update to stop returning early?

Looking at account_end_timestamp() in tools/perf/util/bpf_lock_contention.c:

	/* Now it'll check per-cpu tstamp map which doesn't have TID. */
	if (aggr_mode =3D=3D LOCK_AGGR_TASK || aggr_mode =3D=3D LOCK_AGGR_CGROUP)
		return;

	total_cpus =3D cpu__max_cpu().cpu;
	ts_fd =3D bpf_map__fd(skel->maps.tstamp_cpu);

Because of this early return, will incomplete spinlock and rwlock contentio=
ns
(which use the tstamp_cpu map) still be dropped when using cgroup
aggregation?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423173505.7322=
3-1-suchitkarunakaran@gmail.com?part=3D1
