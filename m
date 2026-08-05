Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB9C397E64
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 19:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785957666; cv=pass; b=EZputePCgO94aXdogdBhUmfqZLK4NQDHpZJtCGY7wVTa2f9AMm65blrINSQslJXeFm1+gKoxon0mVuX86WILX6e/oNijyLbZvcpIJYCDzm0+apB5q52I32XY1aQHN1y82U8aHohXJdPLh0wj97W2PbwJguM/2BZr/ugIx5RSkQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785957666; c=relaxed/simple;
	bh=CMhOrFQ8KIz+hvSxUEKOiemg501ewoWmTpC1tiCKcEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pdfLehR9tMPpFS/qVUj6q38CJEDjvm+vWg0KB35nWLlTRjJzlrudOnBtwm5Y+xRtU+Bqfz/2C7yWipOi5AQdtSYGQDV6Mxsc1dHFXS0LeCjKdb/696AFrYDnI6mVVCMo3yLguLuYBWDLdvGiGTu9tJqSNZPE9gYmXHlMbLEJoHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mI8GWIu+; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mI8GWIu+"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c15a5b265so62841cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Aug 2026 12:20:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785957656; cv=none;
        d=google.com; s=arc-20260327;
        b=hCVCsZvwruTWHrks6/LjlpzsZaj2B1FYc50V/7jCRqEyacVYc7GaMFcfq16Z975XUM
         pXvrbdmpdGYPOJjZWg/W5QSZt7/LlZWixaIfMZDHUD3b4jF34ETmfGtu240eH64kDbnb
         6xtSgIBVakBUVuj+6spUFj0TUx2wiWyV6rl7YbglrjnzNO1oq6qIGe68gQ3e48yD3xAN
         0iY64z15d72QrrdPKVxfxrsyj2dJDVZRDSNg27YuprfLzYFNlw8VBa+20xCuEmkrxP5L
         DYw/D26PuEIWq8Sk0V4QkKl53iivVZtfgyB1ekDdbLEx/QWux6/vebFm9xsbcRswIDWi
         aLXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/DCh0VngPgAaTY9l/XKyPx+TAp9DlAllV2diaHcv4mc=;
        fh=bL/0pZMIpq0PsTSzPUX6n4R5PIhIQg2TF9DfdqyvYDw=;
        b=IC2ccpv6F/1HwRKf8fwTNzBxouiIJPcySxvYhj3fEmqTiCGt9iZsczoSYyNgxsdWPu
         MUG74aaMdsYiCzBaCgNs65bpXtdyEwKSHob7pmqiE1KC+jE/dbzHJG39guKKzGI8dcB3
         McYVSUkOTBix7+lSx3d4reKrpXSPv6mLX36EYwvmRDzZj7dp997peCyJXbjV3A5bOVC7
         jU4P/iwdYOfODB3hQrvuz/pCJOzZ66FblPXgscf54+kBCDeuHM+FK5/L0KvTfmDCW6ck
         NzRji09uHYH8bgBpPWysRTkTtFWLmqm/5K3bKk5+S3ufNqCxsXkWyxhnLHIIofFHnXYr
         Ceyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785957656; x=1786562456; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/DCh0VngPgAaTY9l/XKyPx+TAp9DlAllV2diaHcv4mc=;
        b=mI8GWIu+Z2tbdxHoDGBZehwHxGi9pz6ZsGJCUFCOp8yZPya0vfE3mh8wmz2fFS7EKX
         mYaZa3Vjvd/ix6uONJBWaM3RpYObQeN8udnt6Jokux7L5SEO5ktDMIJj+yn9GavgCSaz
         /o14tvRljhP8+h0STKRNUJ/6xuLKZrJ24yLMaMJGCmYGAuVXSg3j+l0CwyPU+eoj/Eun
         rsZ69dS34O1gg4HtM5ivdqvpv339NbHR2bg0NFq3iZWfvaQ/UP4C2n18W1AdIZDD+2gI
         6jxji6tJgibz/naD9XR0XQ76Lkijl24Q7QTt7hkKaHUF8GnolvHCAVEdqGd1jYN4IJNY
         wgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785957656; x=1786562456;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/DCh0VngPgAaTY9l/XKyPx+TAp9DlAllV2diaHcv4mc=;
        b=i7+7oxMCB96Xg5dLxe680Qu15ye16hBZt6XMgNMTOz9F1NFbI1GSg1xjpwynbcm4r9
         9VWUH6J4kMwsWdTrSrhdnDsfPvLE7vDRy22InkZV07b79FEeIL9+boKDO1D2tlRHyR/h
         PHwhrIzmcQJwb/QomHht6rOOdEKEyGfWWAKcQ5pwrMxXRPs3H4BUrD26mD3aB5OlFYnm
         aLor2TyfvM08qr1FTUOThIN6QqC+Ub0aQ66JE1RcWbcKx0Jy9kN+58bA7ZJDkixgVMdd
         QvIbhw7p3kwGU7Tub/ipntDwpP6a4oQ4fRUJ74UfIbSEFvjNRWpkJyQx3rsYMuh8Frtf
         Hpng==
X-Forwarded-Encrypted: i=1; AHgh+RqdjyONPaaCQtjd+EH+Wa/Uclvx6QHmBSZSZRf2jOFRL5Mfu4waTw5OCirYmK9QmN+ppjevqXSuaQkLdCMN8vxJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq95oDcPaSI6k1hAt/IOyL5Kvst4ivXRivrMXu8jdoeixfBr4v
	QuPupoEbn0sw1DDxwgzBlysoa+w4VXqyoxJY52bkF+AE1TiYWylx4tXbZe/mhrfNQDvtdnfOCq6
	hwPCfgNmyoT8J5xn/LTGZIz7No/lfuK1/x8nLke9o
X-Gm-Gg: AR+sD105QElbJ9E3ekawofZEyb88EY4Xuqp1oYn0vpp6J9kUApO63UdXj1+6K43AreY
	jl7wOOQDYmS07s3qXRw4Wr4RAbPbcJSvQwjCVrAl78+pWCyJp7LMQR3lOIC33BB3U6RNJStj+HB
	rNGJ5dOCRzRjlbIoJFtxY1Zz2kwEkd4kzWXtvIt6yxBI+UTUeE4TJduBqV6B5FC585v/zmVmfav
	OmuUUweGZ1XckBXka0FcOst1+CIxEXdNZwAfzWmj1wi3kccliAiHrNRjjw/JnzcyX27RTaubrUk
	UBo1EHTtOmHv9HnsxinOghugaeuGxduSe9mpbxsIQk5UUQ==
X-Received: by 2002:ac8:7c4c:0:b0:519:b82d:fe62 with SMTP id
 d75a77b69052e-52cfc0c8fd9mr2898101cf.7.1785957654987; Wed, 05 Aug 2026
 12:20:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805133013.235016-1-acme@kernel.org> <20260805133013.235016-13-acme@kernel.org>
In-Reply-To: <20260805133013.235016-13-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Aug 2026 12:20:43 -0700
X-Gm-Features: AUfX_myIp_G48UuYhMbZZ-kQbMAK_QoCf4Pa4LI5K6AeUBKUZCzj_pcs_lioIJ4
Message-ID: <CAP-5=fWVLtNgAS+3f=2tTwH+4AGes=DtMBuivBMN79=Zzxz1iA@mail.gmail.com>
Subject: Re: [PATCH 12/12] perf jitdump: Validate unwinding sizes against
 record payload
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	sashiko-bot <sashiko-bot@kernel.org>, Stefano Sanfilippo <ssanfilippo@chromium.org>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 6:32=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> jit_repipe_unwinding_info() copies unwinding_size and eh_frame_hdr_size
> from the jitdump record into jd-> fields without checking them against
> the actual payload size.  Downstream, jit_add_eh_frame_info() in
> genelf.c computes unwinding_table_size =3D unwinding_size -
> eh_frame_hdr_size, which underflows when eh_frame_hdr_size >
> unwinding_size.  The result is passed as d->d_size to libelf, causing
> an OOB heap read into the output ELF file.
>
> Validate that unwinding_size fits within the record payload and that
> eh_frame_hdr_size does not exceed unwinding_size before allocating or
> storing the values, so a bogus record cannot force a large allocation
> that is then discarded.
>
> mapped_size is likewise taken from the record and was narrowed into an
> int for the mmap2 len computation in jit_repipe_code_load() and
> jit_repipe_code_move(); values above INT_MAX would turn negative,
> producing a wrong mmap2 length.  Use uint64_t for usize so the value
> cannot truncate.
>
> Fixes: 0284fecd13b6db3e ("perf jit: Add unwinding support")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Cc: Stefano Sanfilippo <ssanfilippo@chromium.org>
> Cc: Stephane Eranian <eranian@google.com>
> Assisted-by: Claude:claude-opus-4.6
> Assisted-by: Opencode:mimo-v2.5-free
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/util/jitdump.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index 5f3a53f818c29f58..385c19b864aeee4c 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -462,7 +462,8 @@ static int jit_repipe_code_load(struct jit_buf_desc *=
jd, union jr_entry *jr)
>         u16 idr_size;
>         const char *sym;
>         uint64_t count;
> -       int ret, csize, usize;
> +       int ret, csize;
> +       uint64_t usize;
>         pid_t nspid, pid, tid;
>         struct {
>                 u32 pid, tid;
> @@ -543,7 +544,7 @@ static int jit_repipe_code_load(struct jit_buf_desc *=
jd, union jr_entry *jr)
>
>         event->mmap2.pgoff =3D GEN_ELF_TEXT_OFFSET;
>         event->mmap2.start =3D addr;
> -       event->mmap2.len   =3D usize ? ALIGN_8(csize) + usize : csize;
> +       event->mmap2.len   =3D usize ? ALIGN_8((uint64_t)csize) + usize :=
 (uint64_t)csize;
>         event->mmap2.pid   =3D pid;
>         event->mmap2.tid   =3D tid;
>         event->mmap2.ino   =3D st.st_ino;
> @@ -612,7 +613,7 @@ static int jit_repipe_code_move(struct jit_buf_desc *=
jd, union jr_entry *jr)
>         char *filename;
>         size_t size;
>         struct stat st;
> -       int usize;
> +       uint64_t usize;
>         u16 idr_size;
>         int ret;
>         pid_t nspid, pid, tid;
> @@ -761,6 +762,18 @@ jit_repipe_unwinding_info(struct jit_buf_desc *jd, u=
nion jr_entry *jr)
>                 return -1;
>
>         unwinding_data_size  =3D jr->prefix.total_size - sizeof(jr->unwin=
ding);
> +
> +       /*
> +        * Validate sizes before allocating =E2=80=94 jit_add_eh_frame_in=
fo()
> +        * computes unwinding_size - eh_frame_hdr_size and uses the
> +        * result as a buffer length for libelf.
> +        */
> +       if (jr->unwinding.unwinding_size > unwinding_data_size ||
> +           jr->unwinding.eh_frame_hdr_size > jr->unwinding.unwinding_siz=
e) {
> +               pr_warning("jitdump: invalid unwinding sizes in unwinding=
_info record\n");
> +               return -1;
> +       }
> +
>         unwinding_data =3D malloc(unwinding_data_size);
>         if (!unwinding_data)
>                 return -1;
> --
> 2.55.0
>
