Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D57737A496
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 11:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782126582; cv=none; b=P8MjKTivGK6ZimzSGhovW+ZZg2CfsMFDXNrWS5VhcWn9P/7ApADCG1+WzTxwrg9Hppn/tea8gN1W+u8Jtkg0rM/jWI7CxQN5z54C+0LRHltJkYatHg+FFz8K6TVC/xZxYPhrZFvNGBnRYyAyP3II3ZIjfMDrPIhfbjViRhe2Puw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782126582; c=relaxed/simple;
	bh=tYPP06dJbplDehUpPstvRgVcRmR8WzCL5yROKuM5Fyc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=B30+0CfsWNh7sfDXZVhx/0SjHANqCFheQxWHctQWvIbV8WxFprKntGNTENFGiVb34OJxO9V0E4InylWjBGTa5ShWPPlE4gZwsDTfMhnycaGEU3H9NEuF4UtKgirs8SeDAehL2nNrLjgwmL9px4045CMaYIN8ffumXfYfOt49doc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxbmo+dS; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxbmo+dS"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-137335bc3caso6667365c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 04:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782126580; x=1782731380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xIWdbLLEg9dBfFSLqVtIUmlfUVdjnpVzN85B4SdiLpU=;
        b=jxbmo+dS1Mbbbwk5YD1ce9M8jzlGsXK+lfOkm4C7FmdPQahzPKIAeWcSoaknlr5Cdy
         r6NFHT/2gPkBtwOpxU69Wtxu8uI05QIrWoyVikfJFAcsF+yLJU1eiLjuLvof2JBQAGvS
         +kYhUUF2zxbXPUku1B/qyWIOpUjyl2tFvp9TlnIskrMn4yZPCNlEl8sK2/cLAeUepxfa
         vNA/OLNrKel7bg/xRJzY8G1iHzqC1TXuCEKF7oUi+J6Zss3lXBoLzQOXeaoyJqv+BZMF
         4FtzcwJ/z/x76g56rHtbIlQJZ8wIKlUm/UTw0by4soR32OAz5Cba6e581r8VU/1Dwa1M
         tKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782126580; x=1782731380;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xIWdbLLEg9dBfFSLqVtIUmlfUVdjnpVzN85B4SdiLpU=;
        b=QXJ4JjiBrkS4A5RYWkA8vCe7Xb9xllSYj1QROOs7/TNXl5V/sxx9xqM7nousc1UN6C
         FrdRin3VaACHp6pz/snD6/SzwMbgoWGlHyQ+Ru6QZkdMPRL+P0OdMpkVB5v4aS8b55Oy
         x5UDo5WiJSvZvPyPIYi+Iw3eNr1V1RAFMGBfHgTdXBFcbAoreOxS++LjRrk3KJitFauA
         UpYkaIpWgDFvzUOD8Pq6a2H4Y1cKhwVLNv8QqRC36P500pjnq+FlPUnDyP5u60oN2//v
         anrzhsKU3RkCh/der2lS3d7YSyOA45xbEHg1aQqVAd6DzKHQtJMkBbTssXIwtnQ7L9sK
         X8AQ==
X-Forwarded-Encrypted: i=1; AHgh+Rquvv9NHC96WdP6j7DBRjSnP8nPcQ4+2CFIuOQhua5j/kn9ZYz4D1XLtjUI7XaKJsKIKCFAGFpsYsmHuWUawq00@vger.kernel.org
X-Gm-Message-State: AOJu0YwPpoAchsrFgWGspsagtfmg0iYUz5lql9fiVwXLKNbE8Irx5yJy
	kxfTxbbmi0Lp2YxL7jbOKmvHxxaVqaw4CWKmvjBsESGuAdW+rk9XXJB3
X-Gm-Gg: AfdE7clueNAIXBYOe2Quh27sHQPv3Y0Egz3P2XjGFS6pNhoJ2k380NdXxZfNZSw8Wuu
	UUeS5aYypbCHpDRRI5QgdGsmQ5WmsCwuPxc2E7Rrj1xa3FTLTKwbxD55Pks4nQdzlhzqCIrHVL8
	F56wxFMY8DiMZHLXO+2mxTCUtCP/vGg61yyMl+OnJcjpV5Sgf5WSBFwf3nKS0L74IhStL4zUBxE
	LZmhIp6WsidokCT/CnXXpTT7ItRdEjw15YqRqnlgPbpZVHnq/QI5IaC1Pp0SmL99H3RSCdxDd6n
	YnFIGgnq1N3mcrzszsEUFkrFSSO4KSsJNcQrefTp9HRXznoNioSz0IIoF9dhAEP9rj432p+MoDv
	iUpbrUX3h7p46qeJnkI80LOUEJf0xeK0dFqgCVj6Dn4QfZCyPnMmp4aXJkL4SYZq1jy1cQ19md9
	vvp3ZoBX+02yxcFJD2Ambd+mvBXbKBwA==
X-Received: by 2002:a05:7301:38a4:b0:2f2:6dde:df66 with SMTP id 5a478bee46e88-30c06e303ddmr10114940eec.22.1782126579977;
        Mon, 22 Jun 2026 04:09:39 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2804:2bf0:60e7:ae00:61b2:c320:bcb9:eac0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1bd8d6c7sm10643390eec.16.2026.06.22.04.09.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 04:09:39 -0700 (PDT)
Date: Mon, 22 Jun 2026 08:09:33 -0300
From: Arnaldo Melo <arnaldo.melo@gmail.com>
To: Mark Brown <broonie@kernel.org>, Alan Maguire <alan.maguire@oracle.com>
CC: peterz@infradead.org, acme@kernel.org, mingo@redhat.com, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH perf] perf: Fix btf_vlen() signedness errors
User-Agent: Thunderbird for Android
In-Reply-To: <ffdbf003-5f08-4db8-b633-7ed053a738f1@sirena.org.uk>
References: <20260622103418.579115-1-alan.maguire@oracle.com> <ffdbf003-5f08-4db8-b633-7ed053a738f1@sirena.org.uk>
Message-ID: <A52F0C17-9617-4F5F-9537-C9643F5EF347@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On June 22, 2026 7:53:40 AM GMT-03:00, Mark Brown <broonie@kernel=2Eorg> w=
rote:
>On Mon, Jun 22, 2026 at 11:34:18AM +0100, Alan Maguire wrote:
>> Commit f7a6b9eaff3e6 ("bpf: Extend BTF UAPI vlen, kinds to use unused b=
its")
>>=20
>> extended the return value for btf_vlen() to __u32, triggering
>> errors for cases where an int was used to store return value=2E
>> Fix these cases for perf as was done for other libbpf consumers=2E
>
>I already sent:
>
>  https://lore=2Ekernel=2Eorg/r/20260617130038=2E34534-1-broonie@kernel=
=2Eorg
>
>which I have been using as a fixup since I originally reported the issue
>since Linus' tree is broken, Arnaldo said he'd applied it to the
>perf-tools-next branch but it has not yet appeared in Linus' tree (and
>it looks like he forgot to push it so his copy isn't getting picked up
>in the merge either, the last update was on the 15th)=2E

Its here:

<https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/perf/perf-tools-next=
=2Egit/commit/?h=3Dperf-tools-next&id=3D776bd9ac834556ab6ff6b7ef74b71ac53d3=
7855e>

I think Alan's latest patch has one more hunk, I'll get that one in and th=
en send the pull request to Linus today,

- Arnaldo 
