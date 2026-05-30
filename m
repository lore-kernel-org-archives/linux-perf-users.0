Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D362181AA8;
	Sat, 30 May 2026 20:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780173691; cv=none; b=MI5/yCwrgBeu176Kc9YKo1C5W+ipsdDD4R8ymY+r5WAGCW+T3aOhD1fSzE3dcYD856sJZUNGMTJQs7ukED85sWrtKnwfmtrRvP81N9NFRj4FC7n8g4VNndDH30HuzwTYggFMLSvvT+9xtcpnal5PQ9s8QXbxY+HsBfpysnQpPgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780173691; c=relaxed/simple;
	bh=5By0w1qMomB+iNGthJymGH2cmhqfAJ67KL5GV70icwA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m3+17DtvEUSdz6OV4Bq0RK8EbTAiHzTzKKNbn7TOe7Q3C3mjZk4Y48AW+CIMRXtVWqOTbsaTLJOdjFohzjrrQ2wiH9klebp8N1kzm0iZCI60MWmXSaB2aI33MJiP7h4dYCE4MaXKKSMNksH4fYs3xuGUFw6036NQdl2F1ayC0i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZvU4B2q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZvU4B2q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7181F00893;
	Sat, 30 May 2026 20:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780173690;
	bh=LPsAOz3o1J7sRNOfDz3N6keDmlfcCiVqo3km4jbMTL0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YZvU4B2qWgLIeyyiTwYX7aXVzWeaf2I1dpv+o0KiqK1pDf/qKB+UqfEClTtrLMofQ
	 BZ5kGlkHqTYbWCDjkUCMfkUecKmADIKHtnWPeSdE65x+9nVKpndi/78bdJAwpPYuFJ
	 LJ8iQdU9sOrRENLZFbIPx79HQ3C+D7GWEOGBTu7I4PPNeu2busCE1cocwn0zTaTASB
	 QTLkWlq+eSB11UfrlrkfJRKbLM/UNBQfg6oqkE/SAF0bSS8dJAC4jiHqkW+aD719Kp
	 B66aUxmcGH4CXQXy0H7ea/bbO+5wfAosytlWndjEieaFlwUlwEFSVahUb17JSAa2Vv
	 SEy1uSE5wESSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 RESEND] perf/lock: enable end-timestamp accounting
 for cgroup aggregation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Suchit Karunakaran" <suchitkarunakaran@gmail.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260530195940.78700-1-suchitkarunakaran@gmail.com>
References: <20260530195940.78700-1-suchitkarunakaran@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 20:41:29 +0000
Message-Id: <20260530204130.4C7181F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete lock contentions for per-CPU locks (spinlocks/rwlocks=
) are silently dropped when using cgroup aggregation due to an unmodified e=
arly return in `account_end_timestamp()`.
--

commit 9be2409410efd2d4d44f23abbecf590bbbc25d34
Author: Suchit Karunakaran <suchitkarunakaran@gmail.com>

perf/lock: enable end-timestamp accounting for cgroup aggregation

This commit enables end-timestamp accounting for cgroup aggregation by
tracking the cgroup_id in the BPF program during contention_begin. It
updates update_lock_stat() in userspace and contention_end() in BPF to
use this recorded cgroup context instead of fetching it dynamically.

> diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_=
lock_contention.c
> index cbd7435579fea..1a5bd2ff8ee4c 100644
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

[Severity: Medium]
Since this patch enables end-timestamp accounting for cgroup aggregation,
should the early return for LOCK_AGGR_CGROUP in account_end_timestamp()
also be removed?

tools/perf/util/bpf_lock_contention.c:account_end_timestamp() {
        ...
        /* Now it'll check per-cpu tstamp map which doesn't have TID. */
        if (aggr_mode =3D=3D LOCK_AGGR_TASK || aggr_mode =3D=3D LOCK_AGGR_C=
GROUP)
                return;
        ...
}

Without removing this check, incomplete lock contentions for per-CPU
locks (like spinlocks and rwlocks) appear to be silently skipped when
using cgroup aggregation.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260530195940.7870=
0-1-suchitkarunakaran@gmail.com?part=3D1
