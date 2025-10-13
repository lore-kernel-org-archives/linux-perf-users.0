Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BDF3016E1
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Oct 2025 10:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760352254; cv=none; b=YTEHkzGTxNMqtCWr08lKXGYtgTAvGtApZ0VmS4lL+p4VxyIASNyCKs3VCT7DmgdIUylYv5U2KZ7sT2jIbY/0zyIAX5d5Bht88NY46sviYwBy6jzt57cNdOjh/4iToUBpcUDmI3E75ViLbC0MfXMgq0U3JpfcqXrVB/HPKke08vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760352254; c=relaxed/simple;
	bh=O3X0TiZIveW4k8cyt/JSlo+R3755fvA2/0hcbOzZGbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LwQcFsSLk7/nJW5BzQGkh/mJWGv5dxd4ybEjAk5y5fXAYqwoRYslH1BLLX9GYnDyEWSZPWlOvu5DEr6TTmt0VxL3r6twfZCxtWvApcSwwPZ5U37R6nDhrk3f9Q21V9rrrjIGR6IXD8Vb2Hac4Uaxn7tDwW86k2XLfCH+H0LCcYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVWii0LZ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVWii0LZ"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b4aed12cea3so655088966b.1
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Oct 2025 03:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760352245; x=1760957045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkBdnT8UJZ9spJ4o+LGGXAfuLnGVrF5/StRbxbSJF+Q=;
        b=ZVWii0LZX7SATx5twSWvkHHki0QsOmaYvYfUHma6+1PXiVxE5lzX2SWm7tk9TOtrie
         i5YKhj0fCJuHgRuS/2V3P0ujqbMlE2TDe6k5PZg0LJ0gy9qthDMP95BgbQ9I+eKiY40Q
         0b8s6Xqoaw8n4BfaQiBjaLxnQ5BxuNNVVo7QwEOz+9UCPNuOq/PuoJO2/kanvhaCCFl7
         qRczCW2nzvklGO9yNf6dKqSY4Aq3N2gG4b98dz2FYVW3/wOYxgt58KqQ14Z5bqJBQsEP
         Nzxr3hU3xJaoXsPq2JVlIo3DWRY3zPyghPzaIlTJhM8FJQX+wEMvz83G2+x/GUyIgSqj
         ayyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760352245; x=1760957045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkBdnT8UJZ9spJ4o+LGGXAfuLnGVrF5/StRbxbSJF+Q=;
        b=vKdUzAySsAGS1Xv5Hn9zyXvI8LjvTyMckEgu8s29BmYnInnKGroCsJVcMDa1I6OdbK
         icG5xPISytTrlrkphCAzwdYYzE8EIR0kUMruS48cQy0mLtCad7vrhdajsNFsoNCe26Vx
         sUOGYat0HP/Xq+qwMefkobbpXMktgDFTuZF3u+6kBu/4hdiuN1Tgi4CeX627TPkh7wVY
         PBpA414xGi4X2Cpa2fe9ACLTtNkkbVzzHP7ZWjldNsC4gHZ/Bw64/f1qpY8R99n624zx
         qTK1BiJWp0kLEdTXbV6CCWQSN+rCrTQEkv4Y3Pxk3iygFC0fTKnt+0Lfo6hw2hbUDgc6
         iX2w==
X-Forwarded-Encrypted: i=1; AJvYcCWPlUxI+OALkUyzHR2nc9snS2/2mzutkqtpNU2mdNHlzt43BJ3FUVFppo5DkiU48RpNDNBk5DmBotRwdq0micbC@vger.kernel.org
X-Gm-Message-State: AOJu0YyX4GhC+x13cDMUvj4DvPAKwhuTB7p5tRFoNoYpMjKiRJwiCHql
	0uN2Kk2DbAfKSqVj7l7cWhXy4IqplH/Rw0GzvCEfgJ/EGYNZboMtIs8nOHBzlejjESHOBE6NmPH
	QVhwdM/mRAkHP5D6ceCxoDUYA9AdE09s=
X-Gm-Gg: ASbGncsPFynSLs03HjHF7ul45rDJIwhM9Q/Yv07U2w0SK0W0bZezhKG0FPTzS0XHT7X
	HvGqZ8B6NsYVS2ezd7Ru3cdj2zpPXzu0HElEAMO1+8Nt5Sh0EyCC5T9hdIxVpOUZg9nbZkPIXU5
	vStyoH3nUxw436K72p8lfo1pavNp3n8jBwF3r19yo8HqryT6bbU5IXlK994cbhgjp3/qmnBhe1f
	ryVf00TawCIZOTqXX6qpw31/PS8SQCigyW6I95CPznVUyrGLxACumC6jJY=
X-Google-Smtp-Source: AGHT+IG1e4ZfncCZgDD5eYUYtafn2zCBthgYi2UEPZzzJwoVXS6N1xdM9TrKPkNnz/+k7zM28m93AOJReACKfslbMt4=
X-Received: by 2002:a17:906:6a14:b0:b04:626e:f43d with SMTP id
 a640c23a62f3a-b50ac4dac78mr1925236566b.47.1760352244808; Mon, 13 Oct 2025
 03:44:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013072244.82591-1-adrian.hunter@intel.com> <20251013072244.82591-4-adrian.hunter@intel.com>
In-Reply-To: <20251013072244.82591-4-adrian.hunter@intel.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 13 Oct 2025 12:43:54 +0200
X-Gm-Features: AS18NWB-xW4VG51UVOQO8Z5wayqj5aYVteBt62MXOsi6a1NIBoasXF3ooINhSG8
Message-ID: <CAOQ4uxi2_YNfXLgx+DbJnNe_sf7aJTkrxzn0ocmwgytLrBcysw@mail.gmail.com>
Subject: Re: [PATCH RESEND 3/3] perf/core: Fix MMAP2 event device with backing files
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ian Rogers <irogers@google.com>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Edd Barrett <edd@theunixzoo.co.uk>, Laurence Tratt <laurie@tratt.net>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 9:23=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> Some file systems like FUSE-based ones or overlayfs may record the backin=
g
> file in struct vm_area_struct vm_file, instead of the user file that the
> user mmapped.
>
> That causes perf to misreport the device major/minor numbers of the file
> system of the file, and the generation of the file, and potentially other
> inode details.  There is an existing helper file_user_inode() for that
> situation.
>
> Use file_user_inode() instead of file_inode() to get the inode for MMAP2
> events.
>
> Example:
>
>   Setup:
>
>     # cd /root
>     # mkdir test ; cd test ; mkdir lower upper work merged
>     # cp `which cat` lower
>     # mount -t overlay overlay -olowerdir=3Dlower,upperdir=3Dupper,workdi=
r=3Dwork merged
>     # perf record -e cycles:u -- /root/test/merged/cat /proc/self/maps
>     ...
>     55b2c91d0000-55b2c926b000 r-xp 00018000 00:1a 3419                   =
    /root/test/merged/cat
>     ...
>     [ perf record: Woken up 1 times to write data ]
>     [ perf record: Captured and wrote 0.004 MB perf.data (5 samples) ]
>     #
>     # stat /root/test/merged/cat
>       File: /root/test/merged/cat
>       Size: 1127792         Blocks: 2208       IO Block: 4096   regular f=
ile
>     Device: 0,26    Inode: 3419        Links: 1
>     Access: (0755/-rwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    ro=
ot)
>     Access: 2025-09-08 12:23:59.453309624 +0000
>     Modify: 2025-09-08 12:23:59.454309624 +0000
>     Change: 2025-09-08 12:23:59.454309624 +0000
>      Birth: 2025-09-08 12:23:59.453309624 +0000
>
>   Before:
>
>     Device reported 00:02 differs from stat output and /proc/self/maps
>
>     # perf script --show-mmap-events | grep /root/test/merged/cat
>              cat     377 [-01]   243.078558: PERF_RECORD_MMAP2 377/377: [=
0x55b2c91d0000(0x9b000) @ 0x18000 00:02 3419 2068525940]: r-xp /root/test/m=
erged/cat
>
>   After:
>
>     Device reported 00:1a is the same as stat output and /proc/self/maps
>
>     # perf script --show-mmap-events | grep /root/test/merged/cat
>              cat     362 [-01]   127.755167: PERF_RECORD_MMAP2 362/362: [=
0x55ba6e781000(0x9b000) @ 0x18000 00:1a 3419 0]: r-xp /root/test/merged/cat
>
> With respect to stable kernels, overlayfs mmap function ovl_mmap() was
> added in v4.19 but file_user_inode() was not added until v6.8 and never
> back-ported to stable kernels.  FMODE_BACKING that it depends on was adde=
d
> in v6.5.  This issue has gone largely unnoticed, so back-porting before
> v6.8 is probably not worth it, so put 6.8 as the stable kernel prerequisi=
te
> version, although in practice the next long term kernel is 6.12.
>
> Cc: stable@vger.kernel.org # 6.8
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  kernel/events/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 7b5c2373a8d7..177e57c1a362 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9403,7 +9403,7 @@ static void perf_event_mmap_event(struct perf_mmap_=
event *mmap_event)
>                 flags |=3D MAP_HUGETLB;
>
>         if (file) {
> -               struct inode *inode;
> +               const struct inode *inode;
>                 dev_t dev;
>
>                 buf =3D kmalloc(PATH_MAX, GFP_KERNEL);
> @@ -9421,7 +9421,7 @@ static void perf_event_mmap_event(struct perf_mmap_=
event *mmap_event)
>                         name =3D "//toolong";
>                         goto cpy_name;
>                 }
> -               inode =3D file_inode(vma->vm_file);
> +               inode =3D file_user_inode(vma->vm_file);
>                 dev =3D inode->i_sb->s_dev;
>                 ino =3D inode->i_ino;
>                 gen =3D inode->i_generation;
> --
> 2.48.1
>
