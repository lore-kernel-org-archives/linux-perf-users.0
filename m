Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725EC46EF60
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 19:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662008; cv=none; b=dyCiJor485ZjEVZsnyj24RJw5VX63qTtgPTlXe0yzbWL4LoyIQlU98IbjdiI8gTUKovcuRh+AUQGHAKejG/B/mwJfjKTsLsthtEyouAsMCQH3diTz4AyMew93kiRxJ+Djhc2XQuC7cXxEzCAouVWFsEW3M6MwWH+P6benKGAY1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662008; c=relaxed/simple;
	bh=CYBXUim/74C+v4342siptTSBtQ1HRYLhgRT5VBmICWU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tuuGysJBVNd4KmzHusQiQ1nDCIVOnEUMzZN9XxnwllilKQfGNmr05vaQd/XM2m3h4FjK3+fsJXKTPAhYavPFbJcU0J0Bi1YPgQZhE507WyejfxtdBnyBxU/psXQhXEhGGnHI4oqFRC+qQ5Rk0Vkb4X6dexIMCSZinlfk59sqZVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVHvIT3L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVHvIT3L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6891F000E9;
	Tue, 21 Jul 2026 19:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784662007;
	bh=AQ6j6QDpXKDLBgTb1wA2WGfn1m8eH9y+oRnelICyg94=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WVHvIT3LbGVMGiWZBbPS4Ai2XUbV0tDWRyIoLG+jVDm60zNJPqPXQPDDhGBIf3Kz/
	 YkFh8a/ObiPyusGaQLY2grPw2aKul6Kj1gtYn8ei8K8P4khiDi4dYV0xdftMw/8tKr
	 m8upxk+HTZtZ14JWKZe6iw9tnraLscchSgabFkvYo9LvYYqSH0DsCIMcTP2Ji9WmSD
	 wm7gUrZKRosaIcmdyX9PgtL99iZ3x7lYKNf/NBByQQyOcveD08OXPiA8JSdBkdRvv7
	 2MB3Lql3MjR3mAF+qKsY4nwcCXO3lAZRJGQJ3zra9UuD+gLVD/g8gjH87AFGtSnfBN
	 so0Z2SL/QtAdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/4] perf synthetic-events: Fix line synchronization,
 bounds, and truncation bugs in proc maps reader
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260721182150.94016-3-irogers@google.com>
References: <20260721173347.9163-1-irogers@google.com>
 <20260721182150.94016-1-irogers@google.com>
 <20260721182150.94016-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 19:26:46 +0000
Message-Id: <20260721192647.3C6891F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Bypassing _FORTIFY_SOURCE array bounds checks introduces an ex=
ploitable stack buffer overflow when zeroing event trailers.
- [High] Removal of the stale build ID clearing leaks state and corrupts su=
bsequent kernel module events.

Pre-existing issues:
- [High] Incomplete fix: _FORTIFY_SOURCE array bounds aborts still exist in=
 multiple other synthesis functions.
--

--- Patch [2]: [PATCH v4 2/4] perf synthetic-events: Fix line synchronizati=
on, bounds, and truncation bugs in proc maps reader ---
commit ba0b89af1798a9c26d45cb174748a43558ce4d9d
Author: Ian Rogers <irogers@google.com>

perf synthetic-events: Fix line synchronization, bounds, and truncation bug=
s in proc maps reader

This commit fixes bugs in read_proc_maps_line() and its callers by ensuring
proper line draining on parsing failures. It also adds standard fallbacks
for over-length paths, safely emits timeout flags, and introduces pointer
casts to prevent _FORTIFY_SOURCE array bounds aborts when zeroing trailers.

> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthet=
ic-events.c
> index 5307d707711d8..e0680d770462c 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
[ ... ]
> @@ -463,45 +533,53 @@ int perf_event__synthesize_mmap_events(const struct=
 perf_tool *tool,
[ ... ]
> -		memset(event->mmap2.filename + size, 0, machine->id_hdr_size +
> -			(aligned_size - size));
> -		event->mmap2.header.size +=3D machine->id_hdr_size;
> +		/* Zero the padding and ID header trailer safely! */
> +		memset((char *)event + offsetof(struct perf_record_mmap2, filename) + =
size, 0,
> +		       (aligned_size - size) + machine->id_hdr_size);
> +
> +		event->mmap2.header.size +=3D machine->id_hdr_size;

[Severity: Critical]
Can bypassing the _FORTIFY_SOURCE array bounds checks introduce a stack
buffer overflow regression here?

When this function is called via machine__init_live(), the event union is
allocated on the stack without the extra padding for id_hdr_size:

tools/perf/util/machine.c:machine__init_live() {
    union perf_event event;
    memset(&event, 0, sizeof(event));
    ...
    perf_event__synthesize_mmap_events(tool, &event, ...);
}

If an attacker provides a pathname approaching PATH_MAX in /proc/pid/maps,
size pushes the memset destination to the end of the union perf_event
structure. By bypassing the fortify check, this memset blindly writes
machine->id_hdr_size bytes of zeroes completely outside the bounds of the
stack variable, silently corrupting the stack frame instead of safely
aborting.

[Severity: High]
This is a pre-existing issue, but does the same _FORTIFY_SOURCE array
bounds abort regression still exist in other synthesis functions?

While this patch applies a cast bypass here in
perf_event__synthesize_mmap_events(), similar bounds-violating memset calls
remain in other paths.=20

For example, in perf_event__prepare_comm():

tools/perf/util/synthetic-events.c:perf_event__prepare_comm() {
    ...
    memset(event->comm.comm + size, 0, machine->id_hdr_size);
    ...
}

Since event->comm.comm is a static 16-byte array, if a process name is 15
characters long, the memset begins exactly at the end of the array and
writes id_hdr_size bytes. Under modern compiler flags (_FORTIFY_SOURCE=3D2
or 3), this reliably triggers an abort because the compiler detects
the memset writing past the bounds of the array. The same pattern is
also present in perf_event__synthesize_cgroups().

[ ... ]
> @@ -703,11 +781,6 @@ static int perf_event__synthesize_modules_maps_cb(st=
ruct map *map, void *data)
> =20
>  		memcpy(event->mmap2.filename, dso__long_name(dso), dso__long_name_len(=
dso) + 1);
> =20
> -		/* Clear stale build ID from previous module iteration */
> -		event->mmap2.header.misc &=3D ~PERF_RECORD_MISC_MMAP_BUILD_ID;
> -		memset(event->mmap2.build_id, 0, sizeof(event->mmap2.build_id));
> -		event->mmap2.build_id_size =3D 0;
> -
>  		perf_record_mmap2__read_build_id(&event->mmap2, args->machine, false);
>  	} else {
>  		size =3D PERF_ALIGN(dso__long_name_len(dso) + 1, sizeof(u64));

[Severity: High]
Could removing this explicit clearing of the shared union's build ID leak
state between loop iterations?

The perf_event__synthesize_modules() function allocates a single
union perf_event structure outside the loop and reuses it for every kernel
module via maps__for_each_map().

By removing the explicit clearing of PERF_RECORD_MISC_MMAP_BUILD_ID, if one
module successfully reads a build ID, the flag remains set for all
subsequent modules.

When processing subsequent modules, perf_record_mmap2__read_build_id() sees
the flag is already set, assumes the event already contains a valid build
ID, and reads the stale build ID from the previous iteration. This could
attribute samples to incorrect binaries.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721182150.9401=
6-1-irogers@google.com?part=3D2
