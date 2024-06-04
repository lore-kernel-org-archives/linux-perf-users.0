Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDEC12D758
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Jun 2024 13:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717507622; cv=none; b=sXCyvTr4eDn9SCMwyF7EP9go59hs9FpbYly/HrUOb0iXt25LJNtw2GWywC6AiMfObxnEil0oSCs4CRR5HlUyzwxfxyjIV6Y5W7O+41y/pBQtEYyoQ1BB7fm3NhWNIvp00wTMICFdAfLQ4B0a9dPMoc5WwCFR9wNis8XIbavbfV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717507622; c=relaxed/simple;
	bh=DorZ8GcRiA+1jhlFl7bRpvfLzVEuvr2l+VWFd8oCiVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=C/kjUtz2qS+G1Nnh6RA2ONeN1bopO24DxlhHQnjZaj1iyGtyH7OGKd2JuiNkNuvZBZxCDv3O8ge8FRQ3CizdYIndDQ1RnKKGzg52QIjj9UxjGMh4b220I8bWC6IbWzlzOzzeqvW+J3XfwjEc+5EDzBhuo9oG6gfzWiQ3wU0jmNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foss.arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foss.arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24EE51042;
	Tue,  4 Jun 2024 06:27:24 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74A753F762;
	Tue,  4 Jun 2024 06:26:59 -0700 (PDT)
Message-ID: <f34d5d79-5d44-4a54-8e36-2720f4b25d4e@foss.arm.com>
Date: Tue, 4 Jun 2024 14:26:58 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Why does libtracevent pkg-config detection wipe
 PKG_CONFIG_PATH?
To: Mateusz Kowalczyk <fuuzetsu@fuuzetsu.co.uk>,
 linux-perf-users <linux-perf-users@vger.kernel.org>
References: <cfcaf804-d7b1-4d55-8465-12e1d238aca1@app.fastmail.com>
Content-Language: en-US
From: Leo Yan <niayan01@foss.arm.com>
In-Reply-To: <cfcaf804-d7b1-4d55-8465-12e1d238aca1@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mateusz,

On 5/27/24 01:56, Mateusz Kowalczyk wrote:
> Hi,
> 
> To build recent perf, I'm having to apply the below patch.
> 
> ```diff
> ---
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 7f1e016a9253..b70fef12a977 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -1181,7 +1181,7 @@ ifneq ($(NO_LIBTRACEEVENT),1)
>       CFLAGS += -DHAVE_LIBTRACEEVENT $(LIBTRACEEVENT_CFLAGS)
>       LDFLAGS += $(LIBTRACEEVENT_LDFLAGS)
>       EXTLIBS += ${TRACEEVENTLIBS}
> -    LIBTRACEEVENT_VERSION := $(shell PKG_CONFIG_PATH=$(LIBTRACEEVENT_DIR) $(PKG_CONFIG) --modversion libtraceevent)
> +    LIBTRACEEVENT_VERSION := $(shell $(PKG_CONFIG) --modversion libtraceevent)
>       LIBTRACEEVENT_VERSION_1 := $(word 1, $(subst ., ,$(LIBTRACEEVENT_VERSION)))
>       LIBTRACEEVENT_VERSION_2 := $(word 2, $(subst ., ,$(LIBTRACEEVENT_VERSION)))
>       LIBTRACEEVENT_VERSION_3 := $(word 3, $(subst ., ,$(LIBTRACEEVENT_VERSION)))
> ```
> 
> I don't understand why `PKG_CONFIG_PATH` is overwritten this way. `grep`ing for PKG_CONFIG_PATH reveals that this isn't done anywhere else in the kernel tree. All other uses of `$(PKG_CONFIG)` in the file simply invoke the tool.
> 
> Of course, I do actually have `libtraceevent.pc` available, it's just that `LIBTRACEVENT_DIR` is empty which stops it from finding it.

When I was fixing the cross compilation issue for perf, I also 
encountered the similar issue with you. I have sent a patch series to 
resolve the compilation issue.

It will be appreciated if you could check if the patch [1] can fix your 
reported issue or not.

Also thanks for James' reminding.

Thanks,
Leo

[1] 
https://lore.kernel.org/linux-perf-users/20240604093223.1934236-3-leo.yan@arm.com/T/#u
