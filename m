Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790501C2E
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Apr 2024 21:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712007981; cv=none; b=LskbF5k5MvPbQaZ8ERhlIRvaQoY8HG1SFXfctcGptcrSaIo0NWZXA8e94uOKEuSzVdI+kBSMae24C1AsZzOfJhHcZgpBvqjYFE0vQEEhcG9QOIgP9XThYkI6kyMfG5ke2e+zbXqVfmep1boXAuEUH9OarFLIZZkgUD0Y+1+3Ufk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712007981; c=relaxed/simple;
	bh=alzxmOBYBPRFexrqWx2rPZIK+wEkdka3oHwJKl2HKZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UEGIetlIdKkW/ecxBevn86DElXaO5UiDHJaQoSEFl9MiV+zKvLwcYOpjbRPB7NOxm4tLhoXqfxPyONS1P0lO99l3l+GFKzv+B/qCdyRlsLxAipUcbf7nJRD9zZOmydB5NVnc9VuTtlr0HWl1d2SOGROQwUl2sElEmaehSlwHffc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1def89f0cfdso40885745ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Apr 2024 14:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712007979; x=1712612779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eB/PjIpA6PRw7tGHfJhncGiVnzYRJElpvidrTtCaB0=;
        b=tUHVZMTBqeyA+CKSiUVn/Z5zPT/1QWGLMSvvr+6EpoulQgyqD+vqEeSS4UnbIoUw4V
         gbtoLi84Pj+gEXYQuqaCUYXBt3KDooPXzy8cWkqy3+hzsBRF9l0zNLzyfx8iJ8qbvH9H
         RHr5joPhKGv6wyK43RcKOY4oS4Ryf77CdTvneMdlo3RYmNnWIaqC5/lcQ7UuSh1wjMyU
         D09cxasXFKgmfs3bqwXuFUzfCLHTcOKsbkzGAKtsQRuMwMZIaP2EZbC5gJdF+4V7eOdi
         jc2kfGOTTWTV8RunzyquaneOA+y/qh4SSLXDe3HuuykgStUrakR8PXPz6mcKyTZEezkA
         iGTA==
X-Forwarded-Encrypted: i=1; AJvYcCWLVp8ECUlt1m8Id/IzoxzTPKoF4WmoZLWCUBl8kJz3bBwmUzk8qhjYPv6rG8IeYgkixzkb+I6401Vq1y+79r7b2qcOvZA9OW3nmQbDMdJWaA==
X-Gm-Message-State: AOJu0Yx/tj8ItwK7fBTCyt8heE1h4CUepngBbgurBQUcHpwsICfrDlAI
	u3To42lVjlK4qiZHia0D1VmrPRGnxjj1Mf3Ta2YoKt22FNNpLp0LK1+WjWc1Gx+f0xNd6PMVdE5
	YTAQHdyBx642rudLscYWGVUmRQUg=
X-Google-Smtp-Source: AGHT+IHZSS65U3yKylWy9zgEH541y6gopyrRRzR5fRoL3UcYfDXqDiS18mdg9l+m2sKDnC6htPKZsXYECnphk10b6Lo=
X-Received: by 2002:a17:903:22cf:b0:1e0:73d:9172 with SMTP id
 y15-20020a17090322cf00b001e0073d9172mr21078439plg.23.1712007978835; Mon, 01
 Apr 2024 14:46:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240309072513.9418-1-atrajeev@linux.vnet.ibm.com>
 <20240309072513.9418-4-atrajeev@linux.vnet.ibm.com> <4072f03b-a8a2-5611-901e-bc16e97c3fe6@loongson.cn>
In-Reply-To: <4072f03b-a8a2-5611-901e-bc16e97c3fe6@loongson.cn>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 1 Apr 2024 14:46:07 -0700
Message-ID: <CAM9d7cg1eKQByUcDCbF25Bd8vM2ut5st1zPDzMQEi+nTC8cpsw@mail.gmail.com>
Subject: Re: [PATCH 3/3] tools/perf/arch/powerc: Add get_arch_regnum for powerpc
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>, acme@kernel.org, jolsa@kernel.org, 
	adrian.hunter@intel.com, irogers@google.com, linux-perf-users@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, kjain@linux.ibm.com, 
	disgoel@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Mar 26, 2024 at 2:35=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> Hi Athira and Namhyung,
>
> On 03/09/2024 03:25 PM, Athira Rajeev wrote:
> > The function get_dwarf_regnum() returns a DWARF register number
> > from a register name string. This calls arch specific function
> > get_arch_regnum to return register number for corresponding arch.
> > Add mappings for register name to register number in powerpc code:
> > arch/powerpc/util/dwarf-regs.c
> >
> > Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> > ---
> >  tools/perf/arch/powerpc/util/dwarf-regs.c | 29 +++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
>
> I found commit 3eee606757ad ("perf dwarf-regs: Add get_dwarf_regnum()")
> for x86, would you be able to share how to test these changes? What is
> the difference with and without the patches?

Hmm.. I guess it won't work well without the patch.  This is
needed to map register numbers (from objdump) to what
DWARF can understand (IOW they use different numbers).

Thanks,
Namhyung
