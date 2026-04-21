Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BEE156F45;
	Tue, 21 Apr 2026 00:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776732313; cv=none; b=CvvMZGkbr9aKjXd8CM+L02aDzunCeqNloKD6xpUw8ox5dgWKjviED8ZQ+T4SOJNYfts/g3mxLPVjS6EyoB+oVp+VvQj9QGiqdUpYPv7IJhc1siZVXXw5kyQsSQVVEoaLd8ehJvJNO51JVmpirKK34XKbr2eXW7RGF4qDoqYNBQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776732313; c=relaxed/simple;
	bh=zZCiWNX58ldRE9uO6niC7LJKoDQSavu2WQtxZGKPslM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pmiWvCqrUdpJ3efznbIRjY2LinhTOp+gZPiBDtYGI4xbTtKEG1s5xt8tKDM4B1o6i18l5YwzshlUvhMB+5O/sSVJkYA5suJBplHJyLxvFKVSW/jSZ77KTKE35eqz516+7BiZU64dJ/9aCRKHFZ41IG8QFe+sk8yIM2LTC7cf6Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXGKBwgz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXGKBwgz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE13C19425;
	Tue, 21 Apr 2026 00:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776732313;
	bh=zZCiWNX58ldRE9uO6niC7LJKoDQSavu2WQtxZGKPslM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=XXGKBwgzfs1bBU1pRpN4Jyp+L7NYXy+jmXYb8fbkiMRQv/BwDrun3F5Q6byxj7Jjq
	 PGnjEJ5DwjeAD3NKspUZY8Ey67YtaGMMJKtGcuyiP7TFPmRUkowQATxIQQeyX2VNFj
	 B+uU6FUr8x1cWxX2k2DGEOgLvzrqkL3fO6rNvVRg7ES8xuRpS4Omh0hVQ9eURjoQXA
	 mxvAswsvI5OOAfDyhXBZz51qROOeSdDVvECN5kw0eDA0TwN3rYhzW8mKoelNWmyy6a
	 ctp5IC8Er5LicC3zHFZDIFplNE/9bRGAFeOszTDv+LD95rFbz9mEB2i0O2YaWXbk0a
	 gzMjgtwx6jy8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/lock: enable end-timestamp accounting for cgroup
 aggregation
Reply-To: sashiko@lists.linux.dev
To: "Suchit Karunakaran" <suchitkarunakaran@gmail.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260420184656.331306-1-suchitkarunakaran@gmail.com>
References: <20260420184656.331306-1-suchitkarunakaran@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 00:45:12 +0000
Message-Id: <20260421004512.CDE13C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Incomplete spinlock and rwlock contentions are silently dropped fo=
r LOCK_AGGR_CGROUP because account_end_timestamp() skips the per-CPU tstamp=
 map.
- [Medium] Inconsistent cgroup attribution between complete and incomplete =
lock contentions when a task migrates cgroups.
--

commit 7ba25dc647534f97eb1ae9f34c6c8d38e7fef074
Author: Suchit Karunakaran <suchitkarunakaran@gmail.com>

perf/lock: enable end-timestamp accounting for cgroup aggregation

This commit adds a cgroup_id field to struct tstamp_data to properly account
for incomplete lock contention events when aggregating by cgroup. It records
the cgroup ID at contention_begin and uses it to build the aggregation key
in userspace.

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

Does this fully enable end-timestamp accounting for cgroup aggregation
on per-CPU locks like spinlocks and rwlocks?

Looking at account_end_timestamp() in tools/perf/util/bpf_lock_contention.c,
there is an early return that skips the per-CPU tstamp map:

static void account_end_timestamp(struct lock_contention *con)
{
	...
	/* Now it'll check per-cpu tstamp map which doesn't have TID. */
	if (aggr_mode =3D=3D LOCK_AGGR_TASK || aggr_mode =3D=3D LOCK_AGGR_CGROUP)
		return;

	total_cpus =3D cpu__max_cpu().cpu;
	ts_fd =3D bpf_map__fd(skel->maps.tstamp_cpu);
	...
}

Since account_end_timestamp() skips iterating over skel->maps.tstamp_cpu
when aggr_mode is LOCK_AGGR_CGROUP, are all incomplete contentions for
spinlocks and rwlocks still silently dropped?

[ ... ]

> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/=
util/bpf_skel/lock_contention.bpf.c
> index 96e7d853b9edf..d0e2cad02fa36 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -536,6 +536,8 @@ int contention_begin(u64 *ctx)
>  	pelem->timestamp =3D bpf_ktime_get_ns();
>  	pelem->lock =3D (__u64)ctx[0];
>  	pelem->flags =3D (__u32)ctx[1];
> +	if (aggr_mode =3D=3D LOCK_AGGR_CGROUP)
> +		pelem->cgroup_id =3D get_current_cgroup_id();

If a task migrates to a different cgroup while blocked on a lock, could this
lead to inconsistent attribution between complete and incomplete contention=
s?

The cgroup ID is statically recorded here at contention_begin() and used by
userspace for incomplete events.

However, contention_end() continues to dynamically resolve the cgroup ID:

SEC("tp_btf/contention_end")
int contention_end(u64 *ctx)
{
	...
	case LOCK_AGGR_CGROUP:
		key.lock_addr_or_cgroup =3D get_current_cgroup_id();
		break;
	...
}

Would it be more consistent for contention_end() to also use the statically
recorded pelem->cgroup_id, ensuring that both completed and incomplete even=
ts
attribute the contention time to the exact same cgroup?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420184656.3313=
06-1-suchitkarunakaran@gmail.com?part=3D1
