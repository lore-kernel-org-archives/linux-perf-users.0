Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D823375D9;
	Tue,  9 Sep 2025 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424313; cv=none; b=M1CsjOia4mlhYoGL8y5RDcFUcEUWs/hjB0Erf9l0RV2bnuCbeplq6kIR9F6pT6vaRaQFikx7976klO4RjdTTaf9pN+NWSLiyyr6n7LXnNzq83T69NtqQ0TZmDc0wvuIhJeSP0g1h7eQ9h+OHikGpAF38DYv5ZXMDTBPJbTwi4As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424313; c=relaxed/simple;
	bh=Dh7ZFf1vowKFpLIq1Hkf3W/nsAkPs2ZIJHND2Nezi5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gbM9n6a3KNStv/+2tmO8lP/vNW4DnymPKCJBivUgCRo8q+/KqSOJszjUvbVRrcc0g5PygefUsHRGRabZRzM7hVI2gVk1Srq3F0KQg7+IZzu7xuDk/D2sPnecvXjeGg0gMuOe+tTS1o89eNsBRM12UcBLD8WZn/muDE3ZQdH30Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NX0RG9bW; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NX0RG9bW"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6237202020bso5286452a12.3;
        Tue, 09 Sep 2025 06:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757424310; x=1758029110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFVxVUspXmqQ2cCI0baz9Z+xjA4Wbx8Np4jPs/zc39I=;
        b=NX0RG9bWMI4wtqLpvMhdMZC7WjlCimPACF8z7RaTmA/+nbY9Lb2WSNK4KKztmpxRiN
         6c7eMeY723PUCeRKhL7DDf9SQveydjj987altYFj5WlDyhPcAk4ChTMso1lafW4jQCdC
         w7ViagaJByBP7/OodSGIhSqSFLShkywi0KjD2kmbpMrhy9AzIcg7dFaaMtUg+0ef+Lw2
         NZ6ZNyYs/+jYM/ip5fCKvLWhJhxl7dFCz56xleRKYSklBm5opp7UqRWWBiKTRIg9Givb
         1IZIB2G4Wc81FGaMHU4sNjd3HuuqHgjPCBcGhTtGDfy2smE02noyZCovjPul0cLlU+OF
         KQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757424310; x=1758029110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFVxVUspXmqQ2cCI0baz9Z+xjA4Wbx8Np4jPs/zc39I=;
        b=hjG5TgXIQrO9AitMCiOPVcpufPHVVJp66vbkwEokyz14+0l9nW6O14f/q3pVk206Qb
         hyCJW580TJNO2wRvXx6BUZMmcT+knqkoqPvm+X3W3sHtmfZSD0kWXJ1qFvhMcKKKJ0Ct
         7kXQ9oAUu73oOEKPwLt6UhMJKeLC/cKx8GOwHvt+tK0J3qQNC1W1Mw5dmaV3hi+8pVVu
         XdTZwCSv5pSh2f0knDNYIOindxfChcsgjUIiGZZZWk8zAz6QHcVgAX2iK+bi3tZ3dcCM
         cn4eNJNtzcTWBq/hWPKkSJOcfnAdnPcCfzz1YkkG5B1FX1khTIxYLiXM+AfaaL3RGVeK
         UXiA==
X-Forwarded-Encrypted: i=1; AJvYcCV6fgGDasHVAUsv2D5Qr7xThopBIxlT9eSBahmAWspshpGFMFyPXtnIARNh33HfsV2AnGB3BdnSuyV65Ps=@vger.kernel.org, AJvYcCWas62NvMNq/j/R7U7g8gtv1bMAuSrloD02w1C/5p0+iaEmlk/0fGy0gIQeVKDaad/fpYHC1thepgMv94jBVIvRcw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7aNh6GO2/XMxROdBq2eKcm5MVMrwxIXAsubxw7jvrP/+lLk1P
	yjYcFOuNMCIRIJPdUZ6i0xRJ3efYCVz8q6o28KjWLo5cE6YTnBaWL0QCguLTHdC6dVG8yobImHT
	ccXjrEXWIERj+QSloj/KMX+PxR6WBO2E=
X-Gm-Gg: ASbGnct3ucKhQ7l8L4mVGgPJ3pKZ3hGancEg8Dz2QjOPs60CxvsoxGjuEjPlQJ9POtv
	xHxG4I+/alO4KZH6o7GDUTkbgl9jo3y9NwKtv0o/4FtSAjqS0zfjbyxwD32tk7Rd8NGFWp01V6N
	lYjo5bvYN+cT1Wa74M3R8kdkJzMcUqwnpM+aj0KqicTUHfR6RH5hGSIJSwp/avH+SsI+uiQ3iAb
	00wi8tGp2udO77Tlw==
X-Google-Smtp-Source: AGHT+IEoZZyFb/r7RYDQCtGrnSMdZka2RIUJT2JORh2x2qFUEQIKxWVF71N8OZniC1Dxk1712nLw6c0PfeIDXtPiAUU=
X-Received: by 2002:a05:6402:848:b0:62c:9c9c:fec7 with SMTP id
 4fb4d7f45d1cf-62c9c9cffe7mr818195a12.14.1757424309735; Tue, 09 Sep 2025
 06:25:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909124222.222945-1-adrian.hunter@intel.com> <20250909124222.222945-4-adrian.hunter@intel.com>
In-Reply-To: <20250909124222.222945-4-adrian.hunter@intel.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 9 Sep 2025 15:24:58 +0200
X-Gm-Features: AS18NWCihbM-nbivfcm2bwdcSKx1Lky9w3ZoWFOoia0WNzQPH0bmAFnVYQzeaJs
Message-ID: <CAOQ4uxin36Sk+rppHF+aRrg_J1Pg+ZSjdm9NzyA4mQ8qqoVLFw@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf/core: Fix MMAP2 event device with backing files
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 2:42=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.c=
om> wrote:
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

Feel free to add
Acked-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  kernel/events/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index e203b8d90fd2..9d281785b99e 100644
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
