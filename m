Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8122F4A12
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Sep 2025 21:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758229907; cv=none; b=UpX94vWVPNLWvC72ztLc0W1mkY1O7wGGSXMa0EOjzVPdI4jFZdJmOGI/VrshCq5G2R7dPJwNJ/dwgK2kPLD7bWXTB1R7RSUt2qjpoZskL9tic4aB4Ru3DfEVuN5bDacX+AGZnuamCdqGZzLuEh80Si1lfVdQstii2IZ1fxvz4DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758229907; c=relaxed/simple;
	bh=d/kW/HcYN9nla+sQrwTP7d7AwmwYKGAE1oAjjBx2IvE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=CrmURqPJaOpa/4fzf/uIj/GTgmcEXPMrLDvUN/YhrNjOYYo1zFyPtSWmniF2AW6hZeHLNrG7h35MPW09MLpN2fYD7uwX/evtGb1ZkgxoNztqcbWnR9ZkI/G7g1QAQyRo2bEcsDLItvJfielsEnm7+nbgiM7vCvab5uBSRAktomg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SCx7YY+o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SCx7YY+o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758229904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=haj5Uj8dJJVDzLSrDajsILQl1ABk/7DJdOuc9K4PXFY=;
	b=SCx7YY+oMg6ByHJzDtqMR1AeDKeeyRi2UIQkoK2bU1DnsJsDQhrDF/U117tsUGCGicBu9c
	gtnPH8XHMUPX3xnNHAjkmnaqpKQknGGevSGjNvyZFHjofZgES8aTdUMgSzxW+zFniH3wGM
	cz5f36az0YdCkE+QFbyg60H6uK6aw/Q=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-uDFOUO04MPiscgeAgF-xyg-1; Thu, 18 Sep 2025 17:11:37 -0400
X-MC-Unique: uDFOUO04MPiscgeAgF-xyg-1
X-Mimecast-MFC-AGG-ID: uDFOUO04MPiscgeAgF-xyg_1758229896
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-62f599f0f5aso1514522a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Sep 2025 14:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758229896; x=1758834696;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=haj5Uj8dJJVDzLSrDajsILQl1ABk/7DJdOuc9K4PXFY=;
        b=qeR/bMCUvU1kz/+nmvUsJ4y0Z58EeYnH6M3s9/vy7k2jsMFUS3JtKW8Y7ZkE8bZogV
         XVtW02MNYS1v/4mTRuPskNpKJ6jDSPNtnH795gx9cJc+Ajn6pVxKIz7xYl2+yarHVCsw
         DhMw4XJknWI8wg8e+Ws0Ctm8niu4ixm6LXjJ050KJG+Zqz+wh/YhnigmJTNOzMqVfxYo
         AxswAlaNq/2Hfi4YOQokJjG9Q+9mKixzNFPyqH4/pSfmwzZOGYMSyRbTFhSFrG2LZA/o
         NX/qj5GvHQM/YUu09JZv4ppJk0x6YtBroBEKV+ANvAnPzyXWYzdA1XaNcLeaGb9ukVtQ
         lW0g==
X-Forwarded-Encrypted: i=1; AJvYcCXK1Oaxrnf1x1Sa3gahyNX0DxKmpb7mCCdBbo2AqFtnxRTlZ2h+CInI2JIoa568prLzyRXPRljlBOiRvrPpGSAg@vger.kernel.org
X-Gm-Message-State: AOJu0YwC1uDZSt3BSXN/fNP/ehpTYA/HsvIMzHzyytUO0SoepgFM34H4
	7evkQMvxbVZnthlLE5Mg6ZrIDnD+KPHfmLBzZU1jmX9nxC4hmZ2BXbkYnNdUDkqZTft/fhm9RT0
	SXCm+eYyEXodJTT+Mza7LPZD/2WOcgPNaAV8W18pqSWU/+L0K1V97fWB7RyAVoZdPsHf2N9KqJ4
	5ZBPmA/JcU0jBH9aFEEFYy5YBLcm+/fRBlwpSyWR/u05kNIg==
X-Gm-Gg: ASbGncv7+JXX11DdqQObqtb1iYJe4m17cm2RoAypfujaTXhMYmpFOHdBijvlp2jN0oK
	5IZG5zo2766GwcykFwmfUuKHKDvgb4KtqEIOxIMMyZr7t3VylcBF/RlQcRJdWJkLZPmeGuF+1eF
	GcATyYEPP0ubzQ3pWDyRePudea3Y3oBQv5M7g4wSsM0PTukGmyV6r92Tc=
X-Received: by 2002:a05:6402:4590:b0:62f:26f8:fea0 with SMTP id 4fb4d7f45d1cf-62fc0ae510bmr592309a12.33.1758229895969;
        Thu, 18 Sep 2025 14:11:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVsf0wPfY2krtuiF6FtWzTWN+KTRh5W+pGyw46TzmZ5KI7bREpTcAjgqu3sARTuQvFocsVoOPXRV7Lhci+4OI=
X-Received: by 2002:a05:6402:4590:b0:62f:26f8:fea0 with SMTP id
 4fb4d7f45d1cf-62fc0ae510bmr592286a12.33.1758229895590; Thu, 18 Sep 2025
 14:11:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Anubhav Shelat <ashelat@redhat.com>
Date: Thu, 18 Sep 2025 17:11:24 -0400
X-Gm-Features: AS18NWCQhQ6_-HrdR_kCbVx74ouvilsy7PA-2w8NPyBaEQbcP4k4yjoRnUu5clI
Message-ID: <CA+G8DhLzk-XbwoBbtvwnKZXXadWAqy0aApiOiS1-xPvkZb0sCA@mail.gmail.com>
Subject: Re: [PATCH] perf/test: Skip leader sampling for s390
To: eranian@google.com
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, agordeev@linux.ibm.com, ctshao@google.com, 
	gor@linux.ibm.com, hca@linux.ibm.com, Ian Rogers <irogers@google.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-s390@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>, peterz@infradead.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com, 
	Michael Petlan <mpetlan@redhat.com>
Content-Type: text/plain; charset="UTF-8"

I believe this issue is causing perf record tests to fail leader
samping on aarch64 machines. The important commands from the test:

# ./perf record -e "{cycles,cycles}:Su" -- ./perf test -w brstack
Lowering default frequency rate from 4000 to 1400.
Please consider tweaking /proc/sys/kernel/perf_event_max_sample_rate.
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.019 MB perf.data (210 samples) ]
# ./perf script -i perf.data | grep brstack
            perf   98281 184091.292956:     621736 cycles:
53b844 brstack_bench+0x40 (/root/linux/tools/perf/perf)
            perf   98281 184091.292956:     621765 cycles:
53b844 brstack_bench+0x40 (/root/linux/tools/perf/perf)
            perf   98281 184091.293346:     611236 cycles:
53b784 brstack_bar+0x24 (/root/linux/tools/perf/perf)
            perf   98281 184091.293346:     611266 cycles:
53b784 brstack_bar+0x24 (/root/linux/tools/perf/perf)
            perf   98281 184091.293734:     587649 cycles:
53b844 brstack_bench+0x40 (/root/linux/tools/perf/perf)
            perf   98281 184091.293734:     587678 cycles:
53b844 brstack_bench+0x40 (/root/linux/tools/perf/perf)
            perf   98281 184091.294155:     648439 cycles:
53b780 brstack_bar+0x20 (/root/linux/tools/perf/perf)
            perf   98281 184091.294155:     648469 cycles:
53b780 brstack_bar+0x20 (/root/linux/tools/perf/perf)
            perf   98281 184091.294588:     716679 cycles:
53b844 brstack_bench+0x40 (/root/linux/tools/perf/perf)
            perf   98281 184091.294588:     716709 cycles:
53b844 brstack_bench+0x40 (/root/linux/tools/perf/perf)
            perf   98281 184091.295050:     779147 cycles:
53b814 brstack_bench+0x10 (/root/linux/tools/perf/perf)
            perf   98281 184091.295050:     779177 cycles:
53b814 brstack_bench+0x10 (/root/linux/tools/perf/perf)
            perf   98281 184091.295545:     842413 cycles:
53b8b8 brstack_bench+0xb4 (/root/linux/tools/perf/perf)
            perf   98281 184091.295545:     842443 cycles:
53b8b8 brstack_bench+0xb4 (/root/linux/tools/perf/perf)
            perf   98281 184091.296191:     899736 cycles:
53b77c brstack_bar+0x1c (/root/linux/tools/perf/perf)
            perf   98281 184091.296191:     899766 cycles:
53b77c brstack_bar+0x1c (/root/linux/tools/perf/perf)
            perf   98281 184091.296721:     914623 cycles:
53b794 brstack_bar+0x34 (/root/linux/tools/perf/perf)
            perf   98281 184091.296721:     914652 cycles:
53b794 brstack_bar+0x34 (/root/linux/tools/perf/perf)
            perf   98281 184091.297255:     926741 cycles:
53b7a8 brstack_bar+0x48 (/root/linux/tools/perf/perf)
            perf   98281 184091.297255:     926770 cycles:
53b7a8 brstack_bar+0x48 (/root/linux/tools/perf/perf)
            perf   98281 184091.297813:     966974 cycles:
53b778 brstack_bar+0x18 (/root/linux/tools/perf/perf)
            perf   98281 184091.297813:     967003 cycles:
53b778 brstack_bar+0x18 (/root/linux/tools/perf/perf)
            perf   98281 184091.298394:    1007743 cycles:
53b784 brstack_bar+0x24 (/root/linux/tools/perf/perf)
            perf   98281 184091.298394:    1007772 cycles:
53b784 brstack_bar+0x24 (/root/linux/tools/perf/perf)
            perf   98281 184091.298991:    1043010 cycles:
53b794 brstack_bar+0x34 (/root/linux/tools/perf/perf)
            perf   98281 184091.298991:    1043039 cycles:
53b794 brstack_bar+0x34 (/root/linux/tools/perf/perf)
            perf   98281 184091.299604:    1072961 cycles:
53b794 brstack_bar+0x34 (/root/linux/tools/perf/perf)
            perf   98281 184091.299604:    1072990 cycles:
53b794 brstack_bar+0x34 (/root/linux/tools/perf/perf)
            perf   98281 184091.300234:    1099175 cycles:
53b768 brstack_bar+0x8 (/root/linux/tools/perf/perf)
            perf   98281 184091.300234:    1099204 cycles:
53b768 brstack_bar+0x8 (/root/linux/tools/perf/perf)
            perf   98281 184091.300870:    1121830 cycles:
53b898 brstack_bench+0x94 (/root/linux/tools/perf/perf)
            perf   98281 184091.300870:    1121860 cycles:
53b898 brstack_bench+0x94 (/root/linux/tools/perf/perf)
            perf   98281 184091.301515:    1140634 cycles:
53b788 brstack_bar+0x28 (/root/linux/tools/perf/perf)
            perf   98281 184091.301515:    1140664 cycles:
53b788 brstack_bar+0x28 (/root/linux/tools/perf/perf)
            perf   98281 184091.302174:    1158251 cycles:
53b7f0 brstack_foo+0x40 (/root/linux/tools/perf/perf)
            perf   98281 184091.302174:    1158281 cycles:
53b7f0 brstack_foo+0x40 (/root/linux/tools/perf/perf)
            perf   98281 184091.302838:    1173750 cycles:
53b774 brstack_bar+0x14 (/root/linux/tools/perf/perf)
            perf   98281 184091.302838:    1173780 cycles:
53b774 brstack_bar+0x14 (/root/linux/tools/perf/perf)
            perf   98281 184091.303504:    1186018 cycles:
53b794 brstack_bar+0x34 (/root/linux/tools/perf/perf)
            perf   98281 184091.303504:    1186048 cycles:
53b794 brstack_bar+0x34 (/root/linux/tools/perf/perf)
            perf   98281 184091.304185:    1197272 cycles:
53b7fc brstack_foo+0x4c (/root/linux/tools/perf/perf)
            perf   98281 184091.304185:    1197302 cycles:
53b7fc brstack_foo+0x4c (/root/linux/tools/perf/perf)
            perf   98281 184091.304864:    1208165 cycles:
53b768 brstack_bar+0x8 (/root/linux/tools/perf/perf)
            perf   98281 184091.304864:    1208194 cycles:
53b768 brstack_bar+0x8 (/root/linux/tools/perf/perf)
            perf   98281 184091.306794:    1215537 cycles:
53b914 brstack+0x58 (/root/linux/tools/perf/perf)
            perf   98281 184091.306794:    3426542 cycles:
53b914 brstack+0x58 (/root/linux/tools/perf/perf)

Usually the difference between the leader and sibling counts is about
30 cycles, but occasionally there's a really big difference. When
running the perf record with '-e "{cycles,cycles,cycles}:Su"' the two
sibling events have the same cycle count.
There is no difference between the leader and sibling when running on
x86 systems using the cycles event, but when using the task-clock
event, the results were similar to Thomas' on both x86 and aarch64.

Any advice would be appreciated.

Thanks,
Anubhav

