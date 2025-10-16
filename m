Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B081DF982
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Oct 2025 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760625797; cv=none; b=CRQz0JEn3BsYkJuiEP/px7F8ZGyZLlo18FeBPoyLaZFtZRZU0IZADv2Wj0DFHkqvZ3VhDZySBp6YsILjV/51yd/cAnsfEy59Hptp51wY/Y39nuvCkKxU10fSU3svVPRBwgaEKhC5e3f8IpPLCAGb+2SBUoMRUmrDCaXEFPe8N5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760625797; c=relaxed/simple;
	bh=mLo9X67nbvODoVJVmAZiogbJsrmqjHmTVCmgir0/Oz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LgOTFr+h1pKkq23Dlym0PLniH9WtunPPmitCd/j/qJ9fl1ixbk5Phz6a8ksAY/qd8XA6IQaYpJbjYtoeOqpo/+Tmwe/I0moRBCq3GaFPCbtk2L55ko5sPQdM4sKWglGtPkFIdi5P6FNHf9ODS+SJEnHrP5UA5GLOfRCkVfYGHs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GDs3HYOJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GDs3HYOJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760625793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XdT7/QIKnbznI/kUD96R5WkN9EtcYp7VJJNFM+giWJ8=;
	b=GDs3HYOJE67OCxnh0lj0vaaGpFjcHzb2yKblkXuFSu1Cf144umZyLjxeuUgUufKGgqS+nZ
	NgtDCLgOpRM4IEnsbOzhSvtzK9GvOkDRbv3nyMNhFRR/j7JbpdsqK9UP9k76OWXNZ3UkPc
	lGrYJEtq8iF3XdOom2vk3UGt4vD704w=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-_BTuYBfkOwS0RKbg5t9wNw-1; Thu, 16 Oct 2025 10:43:12 -0400
X-MC-Unique: _BTuYBfkOwS0RKbg5t9wNw-1
X-Mimecast-MFC-AGG-ID: _BTuYBfkOwS0RKbg5t9wNw_1760625791
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-37773b4780dso4657461fa.3
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Oct 2025 07:43:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760625791; x=1761230591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XdT7/QIKnbznI/kUD96R5WkN9EtcYp7VJJNFM+giWJ8=;
        b=skWjFxxC2UZDCI+WKBY3SgAkFJ8SXrJChTi5t3OCZ117/2w6mnsENSpg+RqoCb0spX
         K3ejE2f2G/co4MEDO5wdfr5ONM43PiUBkF137z7ExQa2Fennc/YMoMFyiWF2tqK2fhFW
         JjwnvWNMN1PXADmqOk7BmxC9xFgU7R1j4K7KLAmJ5YPB6pE+LYZLfzpNOL1kMxgaUUoL
         zSb2VscoAJv3uAUCjJkHHRhGheQKQyXS3oBAeL4GtPgIMY0K57FcwXkAwAq8cxsX9huj
         7HjAe+ZMXLEdmiiQ2YjAXbKujhRCRgRvUlISRmNX7Z+KmobVGzAyHG5HMn4aAMipkbtl
         USjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWd3QYCQMteMYR4r7YIoH1FOXsSz6lsjInPIBAbA/I4R9fVbLydbn6LkoXXHTRyu32GX6KLXuWcBGg8A93VkQXA@vger.kernel.org
X-Gm-Message-State: AOJu0YzDm5u0p9i4XUqZGpkcXm0s/4/rtExheIw2uSltOsZLwVBV2uZ5
	mc9XL1lJ3CXzeUVfnvOdRxCkVJUK4q3PDcw6Qsca6+At1ibvMDT/NmQ0+ZoTE+ABk/+yzHrsSIN
	yEV8TxaJt3YwdyVGm8LG3uCaM9KwlQXye97hg3FrTDVZI0zfn87astKwv70TKehz/bLHBKMkDof
	1ZPZuB2pol7aq41pPh7TyCkEx3gjRXVwZAAzfEVHWPNq1zYw==
X-Gm-Gg: ASbGncsrdjdnJqziy/4UWlo9ud8tlF4r7kiukEhtLQvwJY/FyMCSgmBsXgtOntBHgP1
	hc/2dPUnJcDRz9JMPUiB7e53i0jmVdxgP32WKcgkUBEz2Lx49lqkC2U9vT+vbQ67xZAUeV8Eud+
	LfX62Sk2iJNg+eTVqNe6df0+AfrZnxGzLkdT5ArJPpvzeui/dq9KLN4g==
X-Received: by 2002:a05:651c:150e:b0:338:8b9:293a with SMTP id 38308e7fff4ca-3779788963fmr1474881fa.13.1760625790399;
        Thu, 16 Oct 2025 07:43:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFB79mEdlLhUEN7boBqChokhsighxTCT08bwOwiAlY0UPTHc+MRgGYU0Tvy6GZ+ROLg6Vvq+Q7YzXAA7IAGH+Q=
X-Received: by 2002:a05:651c:150e:b0:338:8b9:293a with SMTP id
 38308e7fff4ca-3779788963fmr1474611fa.13.1760625789658; Thu, 16 Oct 2025
 07:43:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G8DhL49FWD47bkbcXYeb9T=AbxNhC-ypqjkNxRnW0JqmYnPw@mail.gmail.com>
 <901d2d1d-647a-4a76-a0ee-d8a687ed3f85@linux.ibm.com> <ff157071-e241-4b81-8241-cfd15e5705ef@linaro.org>
 <7a03fb30-87f9-4737-b59a-9f977acc7549@linux.ibm.com> <296700d2-878b-4eeb-b8cd-0252b2f92479@linaro.org>
 <CA+G8Dh+Odf40jdY4h1knjU+3sSjZokMx6OdzRT3o9v1=ndKORQ@mail.gmail.com>
 <CA+G8DhKDvkojDnwxXKe1iiLWwJ0uwD62-qc4_sJgBDdS+qLu-g@mail.gmail.com>
 <f4eba834-e45c-4eba-9650-5b6720fcd30f@linaro.org> <CA+G8DhKQkTKoNer5GfZedPUj4xMizWVJUWFocP2eQ_cmPJtBOQ@mail.gmail.com>
 <58801744-44e4-4182-ab4e-bfcf8e2bfc69@linaro.org> <aO0ci1wX-J3au0-p@x1> <9e4d4f05-0c34-46b0-aad9-1431bf8cf9f4@linaro.org>
In-Reply-To: <9e4d4f05-0c34-46b0-aad9-1431bf8cf9f4@linaro.org>
From: Anubhav Shelat <ashelat@redhat.com>
Date: Thu, 16 Oct 2025 15:42:58 +0100
X-Gm-Features: AS18NWBea0-3kTnpkc9ZO0vSqCEr55TryuDMKnGorRJFs30SalV3hv_GmTbAEGw
Message-ID: <CA+G8DhJnRB=d+pv0k=uzM18EmhFiQ+AiVu3rb8w=anNgJ=dr2g@mail.gmail.com>
Subject: Re: [PATCH] perf tests record: allow for some difference in cycle
 count in leader sampling test on aarch64
To: James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	Namhyung Kim <namhyung@kernel.org>, mpetlan@redhat.com, irogers@google.com, 
	linux-perf-users@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	dapeng1.mi@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for the late reply.

On Tue, Oct 14, 2025 at 9:29=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> But now that I've seen the older kernel version, I think the issue is
> that the throttling fix isn't present and the specific hardware isn't
> important. If Anubhav confirms a newer kernel fixes it we should look
> into possibly removing the tolerance from the test and start looking for
> exact matches.

I tested again on 6.12.0-124.7.1.el10_1.aarch64 KVM with hardware
Ampere Mt Snow Altramax. I'm getting the same error that I was
initially getting (28 cycle difference between leader and slave
event), although now the difference is 18 cycles. So I don't think
this is just an issue with older kernels:
[root@ampere-mtsnow-altramax-02-vm-10 perf]# ./perf record -e
"{cycles,cycles}:Su" ./perf test -w brstack
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.021 MB perf.data (266 samples) ]
[root@ampere-mtsnow-altramax-02-vm-10 perf]# ./perf script -i
perf.data | grep brstack
            perf   96507 163361.511570:     434471 cycles:
53d4e8 brstack_bench+0x44 (/root/linux/tools/perf/perf)
            perf   96507 163361.511570:     434489 cycles:
53d4e8 brstack_bench+0x44 (/root/linux/tools/perf/perf)
            perf   96507 163361.511733:     422961 cycles:
53d424 brstack_bar+0x24 (/root/linux/tools/perf/perf)
            perf   96507 163361.511733:     422979 cycles:
53d424 brstack_bar+0x24 (/root/linux/tools/perf/perf)
            perf   96507 163361.511887:     402299 cycles:
53d4fc brstack_bench+0x58 (/root/linux/tools/perf/perf)
            perf   96507 163361.511887:     402317 cycles:
53d4fc brstack_bench+0x58 (/root/linux/tools/perf/perf)
            perf   96507 163361.512048:     429218 cycles:
53d4b0 brstack_bench+0xc (/root/linux/tools/perf/perf)
            perf   96507 163361.512048:     429236 cycles:
53d4b0 brstack_bench+0xc (/root/linux/tools/perf/perf)
            perf   96507 163361.512221:     462615 cycles:
53d430 brstack_bar+0x30 (/root/linux/tools/perf/perf)
            perf   96507 163361.512221:     462633 cycles:
53d430 brstack_bar+0x30 (/root/linux/tools/perf/perf)
            perf   96507 163361.512448:     494407 cycles:
53d520 brstack_bench+0x7c (/root/linux/tools/perf/perf)
            perf   96507 163361.512448:     494425 cycles:
53d520 brstack_bench+0x7c (/root/linux/tools/perf/perf)
            perf   96507 163361.512638:     512031 cycles:
53d540 brstack_bench+0x9c (/root/linux/tools/perf/perf)
            perf   96507 163361.512638:     512049 cycles:
53d540 brstack_bench+0x9c (/root/linux/tools/perf/perf)
            perf   96507 163361.512830:     518522 cycles:
53d4fc brstack_bench+0x58 (/root/linux/tools/perf/perf)
            perf   96507 163361.512830:     518540 cycles:
53d4fc brstack_bench+0x58 (/root/linux/tools/perf/perf)
            perf   96507 163361.513028:     538824 cycles:
53d51c brstack_bench+0x78 (/root/linux/tools/perf/perf)
            perf   96507 163361.513028:     538842 cycles:
53d51c brstack_bench+0x78 (/root/linux/tools/perf/perf)
            perf   96507 163361.513232:     559322 cycles:
53d430 brstack_bar+0x30 (/root/linux/tools/perf/perf)
            perf   96507 163361.513232:     559340 cycles:
53d430 brstack_bar+0x30 (/root/linux/tools/perf/perf)
            perf   96507 163361.513456:     577880 cycles:
53d4a8 brstack_bench+0x4 (/root/linux/tools/perf/perf)
            perf   96507 163361.513456:     577898 cycles:
53d4a8 brstack_bench+0x4 (/root/linux/tools/perf/perf)
            perf   96507 163361.513674:     593892 cycles:
53d51c brstack_bench+0x78 (/root/linux/tools/perf/perf)
            perf   96507 163361.513674:     593910 cycles:
53d51c brstack_bench+0x78 (/root/linux/tools/perf/perf)
            perf   96507 163361.513894:     602458 cycles:
53d498 brstack_foo+0x48 (/root/linux/tools/perf/perf)
            perf   96507 163361.513894:     602476 cycles:
53d498 brstack_foo+0x48 (/root/linux/tools/perf/perf)
            perf   96507 163361.514116:     613613 cycles:
53d444 brstack_bar+0x44 (/root/linux/tools/perf/perf)
            perf   96507 163361.514116:     613631 cycles:
53d444 brstack_bar+0x44 (/root/linux/tools/perf/perf)
            perf   96507 163361.514345:     624328 cycles:
53d44c brstack_bar+0x4c (/root/linux/tools/perf/perf)
            perf   96507 163361.514345:     624346 cycles:
53d44c brstack_bar+0x4c (/root/linux/tools/perf/perf)
            perf   96507 163361.514576:     633823 cycles:
53d51c brstack_bench+0x78 (/root/linux/tools/perf/perf)
            perf   96507 163361.514576:     633841 cycles:
53d51c brstack_bench+0x78 (/root/linux/tools/perf/perf)
            perf   96507 163361.514810:     641207 cycles:
53d430 brstack_bar+0x30 (/root/linux/tools/perf/perf)
            perf   96507 163361.514810:     641225 cycles:
53d430 brstack_bar+0x30 (/root/linux/tools/perf/perf)
            perf   96507 163361.515046:     647897 cycles:
53d45c brstack_foo+0xc (/root/linux/tools/perf/perf)
            perf   96507 163361.515046:     647915 cycles:
53d45c brstack_foo+0xc (/root/linux/tools/perf/perf)
            perf   96507 163361.515282:     653546 cycles:
53d438 brstack_bar+0x38 (/root/linux/tools/perf/perf)
            perf   96507 163361.515282:     653564 cycles:
53d438 brstack_bar+0x38 (/root/linux/tools/perf/perf)
            perf   96507 163361.515525:     658367 cycles:
53d434 brstack_bar+0x34 (/root/linux/tools/perf/perf)
            perf   96507 163361.515525:     658385 cycles:
53d434 brstack_bar+0x34 (/root/linux/tools/perf/perf)
            perf   96507 163361.515767:     663233 cycles:
53d46c brstack_foo+0x1c (/root/linux/tools/perf/perf)
            perf   96507 163361.515767:     663251 cycles:
53d46c brstack_foo+0x1c (/root/linux/tools/perf/perf)
            perf   96507 163361.516009:     665425 cycles:
53d444 brstack_bar+0x44 (/root/linux/tools/perf/perf)
            perf   96507 163361.516009:     665443 cycles:
53d444 brstack_bar+0x44 (/root/linux/tools/perf/perf)
            perf   96507 163361.516251:     668471 cycles:
53d410 brstack_bar+0x10 (/root/linux/tools/perf/perf)
            perf   96507 163361.516251:     668489 cycles:
53d410 brstack_bar+0x10 (/root/linux/tools/perf/perf)
            perf   96507 163361.516493:     671104 cycles:
53d404 brstack_bar+0x4 (/root/linux/tools/perf/perf)
            perf   96507 163361.516493:     671122 cycles:
53d404 brstack_bar+0x4 (/root/linux/tools/perf/perf)
            perf   96507 163361.516736:     673910 cycles:
53d4dc brstack_bench+0x38 (/root/linux/tools/perf/perf)
            perf   96507 163361.516736:     673928 cycles:
53d4dc brstack_bench+0x38 (/root/linux/tools/perf/perf)
            perf   96507 163361.516980:     676712 cycles:
53d540 brstack_bench+0x9c (/root/linux/tools/perf/perf)
            perf   96507 163361.516980:     676730 cycles:
53d540 brstack_bench+0x9c (/root/linux/tools/perf/perf)
            perf   96507 163361.517225:     678976 cycles:
53d51c brstack_bench+0x78 (/root/linux/tools/perf/perf)
            perf   96507 163361.517225:     678994 cycles:
53d51c brstack_bench+0x78 (/root/linux/tools/perf/perf)
            perf   96507 163361.517472:     681095 cycles:
53d51c brstack_bench+0x78 (/root/linux/tools/perf/perf)
            perf   96507 163361.517472:     681113 cycles:
53d51c brstack_bench+0x78 (/root/linux/tools/perf/perf)
            perf   96507 163361.517719:     682992 cycles:
53d520 brstack_bench+0x7c (/root/linux/tools/perf/perf)
            perf   96507 163361.517719:     683010 cycles:
53d520 brstack_bench+0x7c (/root/linux/tools/perf/perf)
            perf   96507 163361.517966:     683967 cycles:
53d5bc brstack+0x60 (/root/linux/tools/perf/perf)
            perf   96507 163361.517966:     683985 cycles:
53d5bc brstack+0x60 (/root/linux/tools/perf/perf)
            perf   96507 163361.518213:     685021 cycles:
53d410 brstack_bar+0x10 (/root/linux/tools/perf/perf)
            perf   96507 163361.518213:     685039 cycles:
53d410 brstack_bar+0x10 (/root/linux/tools/perf/perf)

If another sibling event is added then the two sibling events will
have the same number of cycles.
[root@ampere-mtsnow-altramax-02-vm-10 perf]# ./perf record -e
"{cycles,cycles,cycles}:Su" ./perf test -w brstack
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.024 MB perf.data (390 samples) ]
[root@ampere-mtsnow-altramax-02-vm-10 perf]# ./perf script | grep brstack
            perf  104580 166706.554289:     448152 cycles:
537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
            perf  104580 166706.554289:     448170 cycles:
537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
            perf  104580 166706.554289:     448170 cycles:
537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
            perf  104580 166706.554461:     435718 cycles:
537f3c brstack_foo+0xc (/root/linux/tools/perf/perf)
            perf  104580 166706.554461:     435736 cycles:
537f3c brstack_foo+0xc (/root/linux/tools/perf/perf)
            perf  104580 166706.554461:     435736 cycles:
537f3c brstack_foo+0xc (/root/linux/tools/perf/perf)
            perf  104580 166706.554626:     427053 cycles:
537f24 brstack_bar+0x44 (/root/linux/tools/perf/perf)
            perf  104580 166706.554626:     427071 cycles:
537f24 brstack_bar+0x44 (/root/linux/tools/perf/perf)
            perf  104580 166706.554626:     427071 cycles:
537f24 brstack_bar+0x44 (/root/linux/tools/perf/perf)
            perf  104580 166706.554798:     451335 cycles:
537ef8 brstack_bar+0x18 (/root/linux/tools/perf/perf)
            perf  104580 166706.554798:     451353 cycles:
537ef8 brstack_bar+0x18 (/root/linux/tools/perf/perf)
            perf  104580 166706.554798:     451353 cycles:
537ef8 brstack_bar+0x18 (/root/linux/tools/perf/perf)
            perf  104580 166706.554980:     480005 cycles:
537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
            perf  104580 166706.554980:     480023 cycles:
537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
            perf  104580 166706.554980:     480023 cycles:
537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
            perf  104580 166706.555171:     507300 cycles:
537ef8 brstack_bar+0x18 (/root/linux/tools/perf/perf)
            perf  104580 166706.555171:     507318 cycles:
537ef8 brstack_bar+0x18 (/root/linux/tools/perf/perf)
            perf  104580 166706.555171:     507318 cycles:
537ef8 brstack_bar+0x18 (/root/linux/tools/perf/perf)
            perf  104580 166706.555371:     531265 cycles:
537ffc brstack_bench+0x78 (/root/linux/tools/perf/perf)
            perf  104580 166706.555371:     531283 cycles:
537ffc brstack_bench+0x78 (/root/linux/tools/perf/perf)
            perf  104580 166706.555371:     531283 cycles:
537ffc brstack_bench+0x78 (/root/linux/tools/perf/perf)
            perf  104580 166706.555577:     551570 cycles:
537fc8 brstack_bench+0x44 (/root/linux/tools/perf/perf)
            perf  104580 166706.555577:     551588 cycles:
537fc8 brstack_bench+0x44 (/root/linux/tools/perf/perf)
            perf  104580 166706.555577:     551588 cycles:
537fc8 brstack_bench+0x44 (/root/linux/tools/perf/perf)
            perf  104580 166706.555788:     568657 cycles:
537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
            perf  104580 166706.555788:     568675 cycles:
537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
            perf  104580 166706.555788:     568675 cycles:
537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
            perf  104580 166706.556004:     584038 cycles:
537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
            perf  104580 166706.556004:     584056 cycles:
537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
            perf  104580 166706.556004:     584056 cycles:
537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
            perf  104580 166706.556223:     597582 cycles:
537f24 brstack_bar+0x44 (/root/linux/tools/perf/perf)
            perf  104580 166706.556223:     597600 cycles:
537f24 brstack_bar+0x44 (/root/linux/tools/perf/perf)
            perf  104580 166706.556223:     597600 cycles:
537f24 brstack_bar+0x44 (/root/linux/tools/perf/perf)
            perf  104580 166706.556451:     609457 cycles:
538000 brstack_bench+0x7c (/root/linux/tools/perf/perf)
            perf  104580 166706.556451:     609475 cycles:
538000 brstack_bench+0x7c (/root/linux/tools/perf/perf)
            perf  104580 166706.556451:     609475 cycles:
538000 brstack_bench+0x7c (/root/linux/tools/perf/perf)
            perf  104580 166706.556679:     619984 cycles:
537f04 brstack_bar+0x24 (/root/linux/tools/perf/perf)
            perf  104580 166706.556679:     620002 cycles:
537f04 brstack_bar+0x24 (/root/linux/tools/perf/perf)
            perf  104580 166706.556679:     620002 cycles:
537f04 brstack_bar+0x24 (/root/linux/tools/perf/perf)
            perf  104580 166706.556910:     627492 cycles:
537f3c brstack_foo+0xc (/root/linux/tools/perf/perf)
            perf  104580 166706.556910:     627510 cycles:
537f3c brstack_foo+0xc (/root/linux/tools/perf/perf)
            perf  104580 166706.556910:     627510 cycles:
537f3c brstack_foo+0xc (/root/linux/tools/perf/perf)
            perf  104580 166706.557143:     634910 cycles:
537f24 brstack_bar+0x44 (/root/linux/tools/perf/perf)
            perf  104580 166706.557143:     634928 cycles:
537f24 brstack_bar+0x44 (/root/linux/tools/perf/perf)
            perf  104580 166706.557143:     634928 cycles:
537f24 brstack_bar+0x44 (/root/linux/tools/perf/perf)
            perf  104580 166706.557378:     641501 cycles:
538000 brstack_bench+0x7c (/root/linux/tools/perf/perf)
            perf  104580 166706.557378:     641519 cycles:
538000 brstack_bench+0x7c (/root/linux/tools/perf/perf)
            perf  104580 166706.557378:     641519 cycles:
538000 brstack_bench+0x7c (/root/linux/tools/perf/perf)
            perf  104580 166706.557620:     647392 cycles:
537ef8 brstack_bar+0x18 (/root/linux/tools/perf/perf)
            perf  104580 166706.557620:     647410 cycles:
537ef8 brstack_bar+0x18 (/root/linux/tools/perf/perf)
            perf  104580 166706.557620:     647410 cycles:
537ef8 brstack_bar+0x18 (/root/linux/tools/perf/perf)
            perf  104580 166706.557863:     652652 cycles:
5380a4 brstack+0x68 (/root/linux/tools/perf/perf)
            perf  104580 166706.557863:     652670 cycles:
5380a4 brstack+0x68 (/root/linux/tools/perf/perf)
            perf  104580 166706.557863:     652670 cycles:
5380a4 brstack+0x68 (/root/linux/tools/perf/perf)
            perf  104580 166706.558103:     655312 cycles:
537f14 brstack_bar+0x34 (/root/linux/tools/perf/perf)
            perf  104580 166706.558103:     655330 cycles:
537f14 brstack_bar+0x34 (/root/linux/tools/perf/perf)
            perf  104580 166706.558103:     655330 cycles:
537f14 brstack_bar+0x34 (/root/linux/tools/perf/perf)
            perf  104580 166706.558344:     657722 cycles:
537ffc brstack_bench+0x78 (/root/linux/tools/perf/perf)
            perf  104580 166706.558344:     657740 cycles:
537ffc brstack_bench+0x78 (/root/linux/tools/perf/perf)
            perf  104580 166706.558344:     657740 cycles:
537ffc brstack_bench+0x78 (/root/linux/tools/perf/perf)
            perf  104580 166706.558585:     660962 cycles:
537ffc brstack_bench+0x78 (/root/linux/tools/perf/perf)
            perf  104580 166706.558585:     660980 cycles:
537ffc brstack_bench+0x78 (/root/linux/tools/perf/perf)
            perf  104580 166706.558585:     660980 cycles:
537ffc brstack_bench+0x78 (/root/linux/tools/perf/perf)
            perf  104580 166706.558831:     664313 cycles:
537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
            perf  104580 166706.558831:     664331 cycles:
537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
            perf  104580 166706.558831:     664331 cycles:
537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
            perf  104580 166706.559075:     667265 cycles:
537f54 brstack_foo+0x24 (/root/linux/tools/perf/perf)
            perf  104580 166706.559075:     667283 cycles:
537f54 brstack_foo+0x24 (/root/linux/tools/perf/perf)
            perf  104580 166706.559075:     667283 cycles:
537f54 brstack_foo+0x24 (/root/linux/tools/perf/perf)
            perf  104580 166706.559321:     668769 cycles:
537f60 brstack_foo+0x30 (/root/linux/tools/perf/perf)
            perf  104580 166706.559321:     668787 cycles:
537f60 brstack_foo+0x30 (/root/linux/tools/perf/perf)
            perf  104580 166706.559321:     668787 cycles:
537f60 brstack_foo+0x30 (/root/linux/tools/perf/perf)
            perf  104580 166706.559566:     670697 cycles:
537ffc brstack_bench+0x78 (/root/linux/tools/perf/perf)
            perf  104580 166706.559566:     670715 cycles:
537ffc brstack_bench+0x78 (/root/linux/tools/perf/perf)
            perf  104580 166706.559566:     670715 cycles:
537ffc brstack_bench+0x78 (/root/linux/tools/perf/perf)
            perf  104580 166706.559811:     672257 cycles:
537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
            perf  104580 166706.559811:     672275 cycles:
537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
            perf  104580 166706.559811:     672275 cycles:
537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
            perf  104580 166706.560059:     673958 cycles:
537f24 brstack_bar+0x44 (/root/linux/tools/perf/perf)
            perf  104580 166706.560059:     673976 cycles:
537f24 brstack_bar+0x44 (/root/linux/tools/perf/perf)
            perf  104580 166706.560059:     673976 cycles:
537f24 brstack_bar+0x44 (/root/linux/tools/perf/perf)
            perf  104580 166706.560306:     675608 cycles:
537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
            perf  104580 166706.560306:     675626 cycles:
537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
            perf  104580 166706.560306:     675626 cycles:
537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
            perf  104580 166706.560554:     676111 cycles:
537ffc brstack_bench+0x78 (/root/linux/tools/perf/perf)
            perf  104580 166706.560554:     676129 cycles:
537ffc brstack_bench+0x78 (/root/linux/tools/perf/perf)
            perf  104580 166706.560554:     676129 cycles:
537ffc brstack_bench+0x78 (/root/linux/tools/perf/perf)
            perf  104580 166706.560812:     677092 cycles:
537f9c brstack_bench+0x18 (/root/linux/tools/perf/perf)
            perf  104580 166706.560812:     677110 cycles:
537f9c brstack_bench+0x18 (/root/linux/tools/perf/perf)
            perf  104580 166706.560812:     677110 cycles:
537f9c brstack_bench+0x18 (/root/linux/tools/perf/perf)
            perf  104580 166706.561108:     677768 cycles:
537f68 brstack_foo+0x38 (/root/linux/tools/perf/perf)
            perf  104580 166706.561108:     677786 cycles:
537f68 brstack_foo+0x38 (/root/linux/tools/perf/perf)
            perf  104580 166706.561108:     677786 cycles:
537f68 brstack_foo+0x38 (/root/linux/tools/perf/perf)

I'm thinking the problem might be in drivers/perf/arm_pmuv3.c with how
the pmus are enabled. x86 has a function that enables all pmus at once
(arch/x86/events/core.c: x86_pmu_enable_all) so maybe arm needs
something similar.

Anubhav

