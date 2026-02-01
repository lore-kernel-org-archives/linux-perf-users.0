Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0808531D399
	for <linux-perf-users@vger.kernel.org>; Sun,  1 Feb 2026 10:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769942041; cv=none; b=PPzn7uznEADPF50cjG6QktRJm6PvlMljp1MMKGwdmitto57QyC5mhKIMQj5Wv+tuomca+/u5orgEKXGjJyvNlXzH2GpVFk7SdHwEkLi3DEEHMJmG9Fc9ygaW43neJS42hG04XLCkXkAhMlG2EPo97TRYNRnQxU2dj5IBwcpQmOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769942041; c=relaxed/simple;
	bh=LCVi1w9tgKb26P8thxfAdXWHXQkrmDVmsXxXvMJrYv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4dyiL95YuPLs9wVhLt6K3/yeI5fJ4uaB4czIfxf/Tfoc+LvwENnfT7UcKJkNRo/ktwtg/tYDPMbzTjj+d92rM4Z3apXsl8YqVsEN9nEIIOSZ+toNIjHeRgeZO3INKs9AId++E/E/buXXAn3BG2A+ExZSgbjPD9EkveRvL3TpGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBsk4L51; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBsk4L51"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42fb2314eb0so2984317f8f.2
        for <linux-perf-users@vger.kernel.org>; Sun, 01 Feb 2026 02:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769942038; x=1770546838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ltBgBJWZ9IoIK6qZcKGPuw+QqjYZzBZ31BgEFRyKDhU=;
        b=XBsk4L51JhJeJx3OxWvnJX8s10/DJfEFoYBszysx9yUmf1wXKTp2DSy3unCozITI4o
         n80CWqowBGe0x9vDQqV/f1z3+ViruiVRhsPkw/oC2tZef93vIm7ypzWYEjvRdqWljSoK
         5nqpEIGdNnDcVkivb2e16FWVSDNsBCWwEnb2FLcMMN8ZKfHM99/gdnt+l3cv2DpWSlBB
         5Vo6rveZ54ZbW8nkANNGJaVIT9QlQ0m5VGg+hdoOJ1EfIlzPRM3nyR9LIjlgmTugcfFe
         Q0YFxTz7+YYQx3XY+i7cRVCrdI4Iaqm6GBTeZGCBkMoH0fLuxMTYKZiS40TF6DXM2JDt
         NvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769942038; x=1770546838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ltBgBJWZ9IoIK6qZcKGPuw+QqjYZzBZ31BgEFRyKDhU=;
        b=o6iO1GLuR3LwK0f4phmadXBSHB5+BlMy43qJKEwvxwbMAm8ujiFQxVHs/P18hHcJKX
         905VoywbYdPONTI/xNYpcEk2u18mK6CWypqQUVfT1+bx7iD/g+WU/yvbYXtPOmzEHc/N
         Z+mgW5F4GLxNd3WFvnCCBxMaBh3tPxjUb1gYw00x9E+wTTUmreQrOVncqs37H9zk86yG
         cke17KFCzbdZc7ZuUadRxfU1Z/IIKT/E6GtM/F2KyciZG/01WssELfVo9zP30l1p3gdF
         FUf/dUmQmorJ7FuKtxDZN6PYE9ewV20ucFIlQcKAHQ4j/IZIve/2YxGSUrQYmjCZErve
         elhQ==
X-Gm-Message-State: AOJu0YxXndxJZPlHB4vS1ehPPYBih/+gq1cCWyzk2cuEQ9c0niS4IbZg
	J1nQysQXk8ABabqTIe8eYE/PKIwLdJDhl9zxRydZw1vuZWuS5tZyp2KG
X-Gm-Gg: AZuq6aIzGT4LpRuFFZ3U8kbHfuJ2oV9DA7hlThWEnIg8FTwKOsHfQyNE7HE8SfZVawq
	t4gZjAX3IcKTi5YpwasIlgkMihVZlyIsq5OGuvsL+BgIvgVu6z9IIQm3TknXNSLEQGi6ePQJ6To
	mor/P4Ce95vnrkwtWwbBeH+PaRLUSmtqssyqEcqjJ/8VHFTOvZs7Ui+BIcZDlma6LI55QmUxNz1
	wMgfhXEV4EVckJiVPBB/oI9bsRdaYXJ48PAiVvFhpe+W83/xK8cC6hbWEHynwGiEU1rm81h89ja
	d2EyK1fzPdcs+0NvbVHcWdk41ggnDhozkL6y5XsQI2lBgCJp10XAqYHwz4xn5UU+0Rf3p4e+IQA
	k8VZ2hKZ5p/TZ+ejG/42/ME0KUbub0g/1RVsDgQ+vDAwYslsrKX+w6HcwSbE+sR79vopVSo48uM
	6ai+muT8N2uYEiJZASxtOxKoHiELDFkZr9KV5IIvFTP1ukXLleFvvbVqec56HAQJICN6tbiKBYr
	Y7AYVk=
X-Received: by 2002:a05:6000:2905:b0:435:a48a:123f with SMTP id ffacd0b85a97d-435f3aac163mr13213480f8f.42.1769942038127;
        Sun, 01 Feb 2026 02:33:58 -0800 (PST)
Received: from ddolgov-thinkpadt14sgen1.rmtde.csb (ip-109-40-177-195.web.vodafone.de. [109.40.177.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1354205sm36022865f8f.41.2026.02.01.02.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 02:33:57 -0800 (PST)
Date: Sun, 1 Feb 2026 11:33:54 +0100
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1] perf tests: Test annotate with data type
 profiling and rust
Message-ID: <7d3n23li6drroxrdlpxn7ixehdeszkjdftah3zyngjl2qs22ef@yelcjv53v42o>
References: <20260127083030.5909-1-9erthalion6@gmail.com>
 <aXjvF3N5ZGJlZzFi@x1>
 <2frzr2cebxes2qoxofwqshfkb5k3d7jeq72srqnt4ywrlpkz5r@7pzb7cpbm4yw>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2frzr2cebxes2qoxofwqshfkb5k3d7jeq72srqnt4ywrlpkz5r@7pzb7cpbm4yw>

> On Fri, Jan 30, 2026 at 09:44:47AM +0100, Dmitry Dolgov wrote:
> > I'm not managing to reproduce your results, can you please elaborate
> > some more?
> 
> That's most unexpected for me, the test output I see looks like this:
> 
>          : 54     for _ in 1..count {
>     0.00 :   5423b8: mov    %ecx,0x7c(%rsp)
>     0.00 :   5423bc: mov    %eax,0x80(%rsp)
>     0.00 :   5423c3: lea    0x7c(%rsp),%rdi
>    12.28 :   5423c8: call   541f00 <core::iter::range::<impl core::iter::traits::iterator::Iterator for core::ops::range::Range<A>>::next>
>     0.00 :   5423cd: mov    %eax,0x20(%rsp)
>    10.21 :   5423d1: jmp    5423d3 <test_rs+0xb3>
>     0.00 :   5423d3: mov    0x20(%rsp),%eax
>     0.00 :   5423d7: mov    %eax,%eax
>     0.00 :   5423d9: test   $0x1,%rax
>     0.29 :   5423df: je     5423f6 <test_rs+0xd6>
>          : 65     b.data1 += 1;
>    13.69 :   5423e1: mov    0x48(%rsp),%rax     # data-type: struct Buf +0x18 (data1)
>     0.00 :   5423e6: add    $0x1,%rax
>     0.00 :   5423ea: mov    %rax,0x18(%rsp)     # data-type: u64 +0
>     0.00 :   5423ef: setb   %al
>    11.17 :   5423f2: jb     54243a <test_rs+0x11a>
>     0.00 :   5423f4: jmp    542426 <test_rs+0x106>
>     0.00 :   5423f6: lea    0x30(%rsp),%rdi
>          : 73     }
> 
> Where '# data-type: struct Buf' is as far as I understand a manifestation of
> data type profiling succeeding. But my environment has slightly different
> version of rust -- I need to figure out what's going on here, thanks.

I've being testing this in the same way, but without any rust code --
just on a simple datasym workload. Surprisingly, it seems that
'data-type: buf' marks are disappearing even in this case starting from:

c31040085914f1188720073baa43d1483693c0a3 (perf dwarf-regs: Clean up x86
dwarf_regnum code)

I'm not sure yet why this is happening, but don't see anything in the
commit mentioning that -- since there are no code-with-type tests yet,
maybe an unexpected side effect?
