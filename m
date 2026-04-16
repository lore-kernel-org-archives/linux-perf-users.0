Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B1B34CDD
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2026 00:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776301156; cv=none; b=B3kgZziEMkIA9tVv3k5V1NLh9FGJN9BHJYahadMlC6ISzqDXquzzVrvt2XCq7m3ZXSBsef/CxbO7EPxmJHyXbURoSzaQxC2F3XbXcyu5fRCu0fTwLGJF99/Qd2KPM7p8cUb8O2tTeLY7yf8osr0faEs4v+nMdWOWT2Sk5NE3d/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776301156; c=relaxed/simple;
	bh=6hzXo3i6iTG3XfQl6P+1XUZMa5T1tQJjrhm4rz3vufU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l5cNYlffFjpMASiphdOFl3SfzDRCUrQDsZmbmV9shDW1ukqZA8ki+8Aepwoik3ZakBP59FWACLv+was/GfX7rAcMCd7FN9RX4k98tVE9kZG51tf+Wtf5r1rQhQNSryj8NYB8cucLm13ap75fJXU8cb8c1rXx8+/ycJCmNb0f8rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ak2h9jpt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ak2h9jpt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86DAC19424;
	Thu, 16 Apr 2026 00:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776301155;
	bh=6hzXo3i6iTG3XfQl6P+1XUZMa5T1tQJjrhm4rz3vufU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Ak2h9jptgIOShYWpxOFue5hxZGVpc0ZjzLs2pBL+KPG9HPYhf2wemCzFKKYyUpgO8
	 D76ZcgzX0sWXVr7CNP3Mh4sRPp00Zg7kGWX8pmYIjzQvdDDrU9cgT3Kld5xn0FI9k8
	 CEYkotpkRnVciy6nBNXmHTHsPEW8gCspaNnZs7JzEkaONWKzsvQeBdO5xHZYcVK/CB
	 58ZNNpbVZBS7J6xcX0xXdm+YLhjdlZ0p9VGLw5I+G4RKIoLNLnGOgdJQtZun7Dssj/
	 1cAcwNJTq1lqttHgF7s8TJPQy8HT7AXGTeTLxqEy9kPzRcPoAP47OkHG2z/5Cnu80t
	 +STORS5Q5sIsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] perf header: Add section bounds checking to the fd
 read path
Reply-To: sashiko@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260416001424.362797-2-acme@kernel.org>
References: <20260416001424.362797-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 00:59:15 +0000
Message-Id: <20260416005915.B86DAC19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [Critical] The newly added bounds check in `__do_read()` is vulnerable to=
 an integer bypass on 32-bit architectures, allowing a severe heap buffer o=
verflow.
- [Critical] Stack buffer overflow in `perf_header__read_build_ids` and `pe=
rf_header__read_build_ids_abi_quirk` via missing size bounds checks.
- [High] Missing null-termination enforcement in `do_read_string` causes an=
 out-of-bounds heap read and information disclosure.
- [Medium] Adding the section bounds check to `__do_read()` breaks `perf re=
port --header` functionality because `perf_file_section__fprintf_info()` le=
aves `ff.size` uninitialized (zero).
--

commit a967949f0160c2901e835f301c2e340a342b95db
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf header: Add section bounds checking to the fd read path

This commit adds a bounds check to __do_read() to prevent reading past the =
end
of a section when using the file descriptor read path. It centralizes the
check for both buffer and fd paths. It also updates perf_file_section__proc=
ess()
and process_build_id() to support this change.

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 9142a8ba40195..ca0c9e80345b2 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
[ ... ]
>  static int __do_read(struct feat_fd *ff, void *addr, ssize_t size)
>  {
> +	if (size > (ssize_t)ff->size - ff->offset)
> +		return -1;
> +

In perf_file_section__fprintf_info(), the struct feat_fd ff is
instantiated using a compound literal that only initializes .fd and .ph,
leaving .size and .offset as 0.

When feature printing callbacks (like print_event_desc()) call into this
path, will this bounds check evaluate to true (e.g., 4 > 0 - 0) and cause t=
he
read to fail? Could this break perf report --header functionality?

Also, on 32-bit architectures, ssize_t is a 32-bit signed integer. If a
crafted perf.data file provides a large 32-bit length for a dynamic feature
(such as data_len in process_bpf_prog_info()), does the size parameter
implicitly convert to a negative ssize_t (e.g., 0xFFFFFFF0 becomes -16)?

If so, could this negative value bypass the bounds check and cause the
subsequent readn() call in __do_read_fd() to overwrite memory past the
dynamically allocated heap buffer?

[ ... ]
> @@ -2655,7 +2655,12 @@ static int process_tracing_data(struct feat_fd *ff=
, void *data)
> =20
>  static int process_build_id(struct feat_fd *ff, void *data __maybe_unuse=
d)
>  {
> -	if (perf_header__read_build_ids(ff->ph, ff->fd, ff->offset, ff->size))
> +	off_t offset =3D lseek(ff->fd, 0, SEEK_CUR);
> +
> +	if (offset =3D=3D (off_t)-1)
> +		return -1;
> +
> +	if (perf_header__read_build_ids(ff->ph, ff->fd, offset, ff->size))
>  		pr_debug("Failed to read buildids, continuing...\n");
>  	return 0;
>  }

While looking at the build ID processing updated here, does
perf_header__read_build_ids() safely handle crafted event sizes?

If a perf.data file provides an event where bev.header.size < sizeof(bev),
could the length calculation len =3D bev.header.size - sizeof(bev) underflow
to a large positive value?

If it exceeds sizeof(bev) + PATH_MAX, would the subsequent
readn(input, filename, len) call overflow the filename stack buffer?

Additionally, while reviewing the string reading operations in this file
for regressions, does do_read_string() enforce null-termination?

The function reads a length len from the file, allocates exactly len bytes,
and copies the data into the buffer. If a crafted perf.data file lacks a nu=
ll
terminator for a string feature, could subsequent C string operations like
strdup or printf read past the allocated buffer and cause an out-of-bounds
heap read?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260416001424.3627=
97-1-acme@kernel.org?part=3D1
