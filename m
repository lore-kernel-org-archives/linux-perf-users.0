Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7013A339387
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786116765; cv=none; b=h0fyTnTPZA9qdzySr0RmWQNQri27SSKQoXrBXTxk+Htx7KN69/o9E/8gimcBkINWjhlCnS6ZwVabeGbM7NqNmYybn85rwkE3c3a0hMXB0h5cmfuxCIbeHmbmba80/WbBcsJrJA/X1nY7e6in55bi2CRgG2J1IOL7gXpJg8USvJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786116765; c=relaxed/simple;
	bh=d499AoYOemaBWfUCMJkBQTbsPxn2CWhxssR4bFXK0jg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s5sSOoZfzftkjrLfBJTl56vphE2DuOwaUrRnim4fs+X6sevwUswT670YlcICqgH091JP9rGKKYrCYP3zjW2O9sknTAVRHWGB6os7lZirnF7EhIZ9wg1fGFh2+4aq7OEDjbqlAKkK0NZRzO64K41JMEgwgRnExSKaKAvrUGQ1VHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ycj4m0rP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ycj4m0rP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F5B1F00A3A;
	Fri,  7 Aug 2026 15:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786116764;
	bh=iXz4XqulWNd/F3I499CfnZ0F9+kuFzzmU4c0wQ0z2X8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ycj4m0rPjTO+mCcdHjuZ0xB0hQzoWwFuvDUvkuxCcruJk/sMy3ybBu17k/ljJptMr
	 vShvcjVW0gLwnnQUixkRxXAPRwDmp/wFt04RNmUUpg8IfkVIztI3mnDp3LvwvrmtVo
	 x0KY9QPgy8Yc76B02ocYhBEC11v8h4ppuN3l/DMUTvaw5fTh6EmIQOI+KwShOAg4eS
	 PnYVqn/dHaYzYMdKM0afajPNiRkdTodNBeTm/h8kDQx5wgFkuHJ5IxCtv7aOPLje2G
	 F8gQHlY9SUd6YXlIf4qjhPElCMNL31+AeCY59c+ZwpP6SZJhD6aq4jRWxKGjrE/zeE
	 RYSx8NLtA1+Dg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V5 4/6] tools/perf: Add powerpc callback support for
 arch_perf_record__need_read
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260807144135.2607-5-atrajeev@linux.ibm.com>
References: <20260807144135.2607-1-atrajeev@linux.ibm.com>
 <20260807144135.2607-5-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 15:32:43 +0000
Message-Id: <20260807153244.39F5B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Redirecting group sibling reads to the group leader incorrectly =
accumulates the leader's event count instead of the HTM sibling's pending r=
ecord count, leading to silent data loss and spurious warnings.
--

--- Patch [4]: [PATCH V5 4/6] tools/perf: Add powerpc callback support for =
arch_perf_record__need_read ---
commit 27e1bb8fdcf56e1c7b4262795fafefb9a6b92d9e
Author: Athira Rajeev <atrajeev@linux.ibm.com>

tools/perf: Add powerpc callback support for arch_perf_record__need_read

This commit implements the arch_perf_record__need_read() hook for powerpc.
It reads the pending record count for HTM events to determine if more data
needs to be drained during the recording loop.

> diff --git a/tools/perf/arch/powerpc/util/evsel.c b/tools/perf/arch/power=
pc/util/evsel.c
> index 2f733cdc8dbbe..2b7851c706774 100644
> --- a/tools/perf/arch/powerpc/util/evsel.c
> +++ b/tools/perf/arch/powerpc/util/evsel.c

[ ... ]

> +/*
> + * powerpc implementation of arch_perf_record__need_read().
> + *
> + * Reads event->count for every open HTM evsel by issuing a direct
> + * read() on the event fd with a plain u64 buffer, bypassing the
> + * PERF_FORMAT_GROUP path in perf_evsel__read().  When an HTM evsel is
> + * a group sibling, evsel__config() sets PERF_FORMAT_GROUP on its attr;
> + * perf_evsel__read() would then call perf_evsel__read_group() which
> + * sizes the buffer by evsel->nr_members (0 for siblings), causing the
> + * kernel to return -ENOSPC.  Reading the fd directly with sizeof(u64)
> + * retrieves the HTM driver's plain pending-record count regardless of
> + * group membership.
> + *
> + * Returns: 1 if more data exists, 0 if collection is complete
> + */
> +int arch_perf_record__need_read(struct evlist *evlist)
> +{

[ ... ]

> +	/* Read HTM event counts to check if more data is available */
> +	evlist__for_each_entry(evlist, evsel) {
> +		struct perf_evsel *rd_evsel;
> +		struct xyarray *xy;
> +
> +		if (strcmp(evsel__pmu_name(evsel), "htm"))
> +			continue;
> +
> +		/*
> +		 * For group siblings nr_members =3D=3D 0, which makes
> +		 * perf_evsel__read_size() return 0 and readn() fail.
> +		 * Read through the leader instead; perf_evsel__read_group()
> +		 * extracts the leader's own count from the group buffer.
> +		 */
> +		if (evsel->core.leader !=3D &evsel->core)
> +			rd_evsel =3D evsel->core.leader;
> +		else
> +			rd_evsel =3D &evsel->core;
> +
> +		xy =3D rd_evsel->sample_id;
> +
> +		if (xy =3D=3D NULL || rd_evsel->fd =3D=3D NULL)
> +			continue;

[ ... ]

> +		for (x =3D 0; x < xyarray__max_x(xy); x++) {
> +			for (y =3D 0; y < xyarray__max_y(xy); y++) {
> +				struct perf_counts_values count =3D { .val =3D 0 };
> +
> +				if (perf_evsel__read(rd_evsel, x, y, &count) =3D=3D 0)
> +					total_pending_records +=3D count.val;

[Severity: Medium]
When an HTM event is a sibling, does this inadvertently read and accumulate=
 the
group leader's value rather than the HTM sibling's pending record count?

The block above redirects reading to the leader, and then perf_evsel__read()
is called here. For group leaders, this delegates to perf_evsel__read_group=
(),
which extracts only the leader's count and discards sibling counts. This wo=
uld
accumulate the wrong event's data. If the leader is a non-HTM event like
cycles, its continuously increasing counter will be read instead. This might
cause the drain loop to falsely believe data is still pending, exhaust the
drain retry limit, and emit a spurious warning, while ignoring the actual H=
TM
sibling's pending records.

Also, the function comment explicitly mentions bypassing the PERF_FORMAT_GR=
OUP
path in perf_evsel__read() by issuing a direct read(), but this code direct=
ly
calls perf_evsel__read(). Could the comment and implementation be out of sy=
nc?

> +			}
> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807144135.2607=
-1-atrajeev@linux.ibm.com?part=3D4
