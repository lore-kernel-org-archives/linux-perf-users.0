Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC11224886E;
	Sun,  6 Sep 2026 20:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788726334; cv=none; b=r89Fn5gcccZpeoifrDViHDYgZXKFUV6zlvjaEb53vQAMxo2OHJ6VEDaDeV4XzLNoe807BOt9k/HxhKhgz5VjUEeWucSSGjXlT+zuhuWO6P7TLzwka3RQOoda3qwJBR98lvDAFozF3kepPrceC1yLg88/lskaTs6wWEBbbF5wDkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788726334; c=relaxed/simple;
	bh=8ejmmdAuyMW9uGC4dM26FFLw/LTj/9YWoy48gXkRPZk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TfCTn1YVxSPAfYQskyREIBFwX+EEZVMYNmrgUTy0Y8oTTd9Xjay+ipqbW4nvC43TxCBpiQe5/mc+DHhj9Ys68ur7r52tAi9nCy/SuVrAr+xsJ1XCvxYMOvqVyQ1X/AQmnbbjfU20+m6qJfVnj7EY2EW1x86ty1v2Ky8CWK2+W8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4uvPxt5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4uvPxt5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC9B1F00A3A;
	Sun,  6 Sep 2026 20:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788726332;
	bh=ceCg5mTBYbmPo7k4oPwd59Y7USKk0gcoj96Br1/Pf94=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I4uvPxt5d6r8MKkWk/K1DsoIVLlXe9bj2HbdMbmY53uhG9Oj6r9TvOnp7ZvLl6F/Q
	 hdD7bus3N1/YzGInL7wyi6SbWw+5n1ajQT738ihvCPGugmXPqO+XzSWNozFP+/ubwi
	 vop/t/stXNjnuIZz8Nu9GYx2z1exDet+CcOA/9jVdhfBppOdpbVVaqMO2GmijrjL9w
	 iQWRp9GWo5WCeXoWixT4l6YCJ9Bgr3ZXLce9DneVwoNy3HBz4C51M1tN7yrq/nHYg2
	 P3/wUitDiPgY74K8QfZMfcSXgv82qk1X1BNE9QpVh+8kT1eoqgB2/3YDQm9/AN2Q0N
	 65CYW1b8JuRvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/3] perf tools gtk: fix two hierarchy-view stack
 buffer overflows
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260906-perf-gtk2-v7-3-1ece839fbca0@gmail.com>
References: <20260906-perf-gtk2-v7-0-1ece839fbca0@gmail.com>
 <20260906-perf-gtk2-v7-3-1ece839fbca0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 20:25:31 +0000
Message-Id: <20260906202532.2BC9B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Buffer state (`hpp->buf` and `hpp->size`) is permanently consumed =
across sibling nodes in the hierarchy, leading to buffer exhaustion, missin=
g text output, and an out-of-bounds stack read (info leak).
--

commit 4426046073bc5d6534ae6439f098dee3dfc79459
Author: Matt Turner <mattst88@gmail.com>

perf tools gtk: fix two hierarchy-view stack buffer overflows

This commit fixes two stack buffer overflows in the perf GTK hierarchy view.
It replaces unbounded strcat calls with scnprintf in header building and
clamps the buffer advance in perf_gtk__add_hierarchy_entries.

> diff --git a/tools/perf/ui/gtk/hists.c b/tools/perf/ui/gtk/hists.c
> index 716dcf02bd0e8..342d4c3fecb01 100644
> --- a/tools/perf/ui/gtk/hists.c
> +++ b/tools/perf/ui/gtk/hists.c
> @@ -449,7 +449,7 @@ static void perf_gtk__add_hierarchy_entries(struct hi=
sts *hists,
>  		bf =3D hpp->buf;
>  		size =3D hpp->size;
>  		perf_hpp_list__for_each_format(he->hpp_list, fmt) {
> -			int ret;
> +			int ret, inc;
> =20
>  			if (fmt->color)
>  				ret =3D fmt->color(fmt, hpp, he);
> @@ -457,7 +457,18 @@ static void perf_gtk__add_hierarchy_entries(struct h=
ists *hists,
>  				ret =3D fmt->entry(fmt, hpp, he);
> =20
>  			snprintf(hpp->buf + ret, hpp->size - ret, "  ");
> -			advance_hpp(hpp, ret + 2);
> +			/*
> +			 * ret can be as large as hpp->size - 1, so ret + 2
> +			 * can exceed hpp->size. advance_hpp() doesn't clamp,
> +			 * so passing that through would underflow the
> +			 * size_t hpp->size and let a later fmt->entry() in
> +			 * this loop write past the end of the caller's
> +			 * stack buffer.
> +			 */
> +			inc =3D ret + 2;
> +			if (inc > (int)hpp->size)
> +				inc =3D hpp->size;
> +			advance_hpp(hpp, inc);
>  		}
> =20
>  		gtk_tree_store_set(store, &iter, col_idx, strim(bf), -1);

[Severity: High]
This is a pre-existing issue, but does this logic permanently consume the b=
uffer
for all subsequent sibling nodes in the hierarchy?

While this patch successfully fixes the underflow by clamping `inc`, the bu=
ffer
state (`hpp->buf` and `hpp->size`) is never restored at the end of the outer
loop for the next sibling iteration.=20

Because the state is saved at the start of formatting (`bf =3D hpp->buf;`) =
but not
restored across the outer rb-tree traversal loop, the 512-byte buffer is
permanently consumed as the tree is traversed.

When the buffer is completely exhausted (`hpp->size` hits 0), `bf` points
past the end of the original 512-byte stack buffer. Doesn't this mean the
subsequent `strim(bf)` call will perform an out-of-bounds read on the stack,
leaking adjacent uninitialized memory into the UI?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906-perf-gtk2-=
v7-0-1ece839fbca0@gmail.com?part=3D3
