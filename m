Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB9722F11;
	Tue, 21 May 2024 17:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716311274; cv=none; b=bglJvZ5laAuiVXs7hys5rJFtb7zOQqRVXWUslAAjS60WKzaqWBSrZx3dcKZyL2ibdXwfWismC3UkyvXbU9L7NnoDw15GLIPOQcWCXFt0s+K6csu5QrLl3k9tMQWK6HyCrNu/cFBmjnuSni/3xnb1FiFU9nsiIjQ9nQspq5OGooc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716311274; c=relaxed/simple;
	bh=4f/C9c7ipxOsSvQmsAVBs2332WEtJ7P3HVXcExUQcgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kogstMHotsCLJDEzZc4J0Onik1zjK7LHO/DPa0JHBJFabK/bytkezLVhwpdbGE6GhcsDEUkAg0Lsk9LIC2OKsVhxTjvWl+lDZcfbqHo1YabHygCMsLsESUYj/u4CJXz5zcwKc/CLqCK3XsASHgcrx8kkkG5oWVS5z4dwfLEM0HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so487657a12.0;
        Tue, 21 May 2024 10:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716311273; x=1716916073;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xg+oV7v8UxI/sVUAL8gF5mbiN42OB/uM83jie5ZyfWc=;
        b=Kakh+U5AjjFLVXOtRQLyCWyhyWahO5jVL7KTszYs8tgCvqrmEYq/Th9xDIjTQT4dIf
         uCbfp6knpQARvE/SpyBnv/Ud3+oBc0xNh67fyZHIoiG7MBD5G8TSC7wX/swZJexxTnd7
         ThlUsgOcv5KqQYdcuLFsyVn6Om/3Xx5TiGqqwqMM3jwz/3J0V4vpfqdqOOJebubFkeRC
         gW3/WyPFIniLjog2hezn/TStVvcPB4Cs8tO5h9F3y0pf15QWVWDuRBoSsxTir23S2XE6
         j8/+o3c6Lcq1sB9NCvTQaLX+9gx5Oml/goT8a7hLrS2JZ9Xs47ebV/vuXZt50jWobDXy
         WflA==
X-Forwarded-Encrypted: i=1; AJvYcCUA74g2RowsL/lytv9c4aBzDm66Q5Bn0syY785zplX1WgTidOf07/DkRceW6QdtQp3h8xA1mWL4FQYechuqjt4MsOKSUrY8DbjJYuvmQg7Gz3wZ5k7Jcae/QvbECUMR1X33hBYCNCf3jtyIfov6KA==
X-Gm-Message-State: AOJu0YxmKC338jGtDgyjFrx1Jpm67l4Npo3nKnFbP14nLIG14F3Tn5Z7
	JLx7or1AMwrJHodt4C5udKC/Acfd3iXjepifTyPDNrhW9mwNhpg1J40yyrNYiGakR4BbrNiqckd
	J9KyI5ZjAidQkPzCiQU/UWj8zvcA=
X-Google-Smtp-Source: AGHT+IFvFYzo6dlUwfBLl6Qah/52Q9PZ92l8yj2n5Wpl/LRcNcQOQbhJZ6imF7X8p/pV71lwH0gTuIYtCiB22x04gpQ=
X-Received: by 2002:a17:90b:683:b0:2bd:768b:6df8 with SMTP id
 98e67ed59e1d1-2bd768b6f5emr5439960a91.19.1716311272794; Tue, 21 May 2024
 10:07:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZjssGrj+abyC6mYP@gmail.com> <CAP-5=fUvLiCDVDFFfJ78ng4T1FZ8j2N9Yt1sGTeGsupkbFEEug@mail.gmail.com>
 <ZkG4LWr7w11wQ/PR@gmail.com> <CAP-5=fVHrKcqwczoU1uMD4tP5DTVhfQ1T_hXnm_y5Ji3M6K_ag@mail.gmail.com>
 <ZkJK3x3zQ9a4wp8E@gmail.com> <CAP-5=fUh+GoqERAF-qf8zx4kwq2uzwR2Ugop5XOkPexYGAqF3A@mail.gmail.com>
 <CAP-5=fWXDPfNqLz6DHYe9+dev_e6X5TcTe_xzOOz27yDkT7o7A@mail.gmail.com>
In-Reply-To: <CAP-5=fWXDPfNqLz6DHYe9+dev_e6X5TcTe_xzOOz27yDkT7o7A@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 21 May 2024 10:07:40 -0700
Message-ID: <CAM9d7ch5HTr+k+_GpbMrX0HUo5BZ11byh1xq0Two7B7RQACuNw@mail.gmail.com>
Subject: Re: Makefile.perf:1149: *** Missing bpftool input for generating
 vmlinux.h. Stop.
To: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Ian and Ingo,

The failure happens when you don't have vmlinux.h or vmlinux with BTF.

ifeq ($(VMLINUX_H),)
  ifeq ($(VMLINUX_BTF),)
    $(error Missing bpftool input for generating vmlinux.h)
  endif
endif

VMLINUX_BTF can be empty if you didn't build a kernel or
it doesn't have a BTF section and the current kernel also
has no BTF.  This is totally ok.

But VMLINUX_H should be set to the minimal version in
the source tree (unless you overwrite it manually) when you
don't pass GEN_VMLINUX_H=1 (which requires VMLINUX_BTF
should not be empty).  The problem is that it's defined in
Makefile.config which is not included for `make clean`.

Can you please verify if the below patch fixes it?

Thanks,
Namhyung

---8<---

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 5c35c0d89306..e6d56b555369 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -214,6 +214,7 @@ NON_CONFIG_TARGETS := clean python-clean TAGS tags
cscope help

 ifdef MAKECMDGOALS
 ifeq ($(filter-out $(NON_CONFIG_TARGETS),$(MAKECMDGOALS)),)
+  VMLINUX_H=$(src-perf)/util/bpf_skel/vmlinux/vmlinux.h
   config := 0
 endif
 endif
