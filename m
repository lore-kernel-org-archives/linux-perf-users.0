Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6AA198E8C
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Apr 2025 17:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744220589; cv=none; b=DAGyq2sp4mzSg5hHQVlTZaJNI5Ed/M3UaBSy8W/ZyvHd527F9LJGRqUijCxWlqLmqWmD+TfP8PcrYCokgrjEPBVZ/p9aSYY9/XTuyRflsqOklJRrZlTxZNuE/zvLNw9znS4ULn9OzQuLU8W+3HOFoJPthQ32eIdsYhopKmtcMcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744220589; c=relaxed/simple;
	bh=lRxI+jgjay9pKUmN0TeFsWrhNbEejH50c+vkSwDitQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k+z13+hD+W4BUpWMUW3VfuCnBadx8aP+UGEAZ/5ku+pgBEML01lFc20m1Q8U9ttjreeEPuxD+c/43MmNDNrqqP8XvX1tvMR2+yTUNeQiKVTNEByOCHfMBZHQqLsdJcG0uXoPY2WdW2V3s9o8o74UqhcdjTNZNZlMiRiQCWIeDSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=C5ftweSs; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="C5ftweSs"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-72c14138668so1749731a34.2
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Apr 2025 10:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744220586; x=1744825386; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Kt5WVaZb4BQFtiAQsh2ErIlcSlCiMVxNUGwBblocwMA=;
        b=C5ftweSsbfpVi6il8n55tWMhCNpdE85smmpv75UFECvYCBlmWFq6DSDazkFMwLxwxq
         HpwGSGjjFWMtUHrH7ZDScircNrSghuGfR3GxcJrYvhYgVcGlzJ6pMeWMOVlZIuOGqEpC
         Fjn22uHpAVznadAaJd15nxayy/yiQGYCqlFCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744220586; x=1744825386;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kt5WVaZb4BQFtiAQsh2ErIlcSlCiMVxNUGwBblocwMA=;
        b=ekMPVvGBUBL8Q9ouBm8ceEjStk72UWt4d8wXQ0JzWtjJUAabuuhs7obhj7qWSIw81F
         9RPwoTG4ODN47ZxpQ8/d474c+Z43dAc65A9BSccuL5rgjp85jnluW0/54gmRvxs9U0p6
         0ro9BCuAmWsOUS7mlU15us1Ko0D+5jMNt73xXuJ3FzyQXXhNTvmYtPOHadjhCDkuas08
         ce2cbq6ZsvKGVCQxwWdN7zoAhfkmbTwn62sh0njC9TMwfXTB7RnrBYJBlhI2DXm1LgSV
         211G/lnYwElu1rjaASvhE+hJf8+TUCx1rav/pTqu5XP60cPMk3gN39ESQkzhOsQgqu4X
         GEMg==
X-Gm-Message-State: AOJu0Yya0XrKwReD+RyW1GVFliyshKoVanaCtRHH40JaT7/Pyu/e5Bir
	KljkUGpij4lMcys3IPztDNogGigAQkkMNR+FWxa0llOjYE+N8nHVAP+LiYPZazgSC0djWheXiug
	njw==
X-Gm-Gg: ASbGncv1Ewe8elqdy1kHdHCT2xHgvj4Zc8zTj1mQ8ovNlSYwx1r+h0PbKcc6GI+cLK1
	QBOV9U2pqM7yJc7jvtqDAvzlcyApSIOXRmiYV5+XM2+auN2yat1l1ClMmyjLGJUuYPgVGS+1At+
	j5a3IAIiOmmQHQdxgtBSbfq8Kp3XjIpwXsxlMht+uwPflTEP2einiuNvABQ4KpucjuN6tOUcp1X
	yNgDK+GpZXGn6F9FMCELPkB5cBRuF2HJRWrn0+/xne1KDDujeJX399cNPNngcpyjxb8hgL3w8yZ
	9hVZ5/7zTsI3TVlg8aGQaLF1sStIm7IqUk6fiRiDIPU3WHS5Wk4q9l+Zjv/gHe4IUOzoQltgopy
	mVtHy
X-Google-Smtp-Source: AGHT+IGdWqEnkib7P9d+6JYuGdhpFntHDxgIXjmY+YFotvpzJ2QaVSN1tikBNlkjMRimiEzAhKFGFQ==
X-Received: by 2002:a05:6830:6285:b0:727:38a3:8a63 with SMTP id 46e09a7af769-72e71b87178mr2594618a34.21.1744220586491;
        Wed, 09 Apr 2025 10:43:06 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72e73d8acb4sm249010a34.29.2025.04.09.10.43.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 10:43:05 -0700 (PDT)
Message-ID: <15a2bf25-8da4-4e8c-a5d2-bcfb6a1e6515@broadcom.com>
Date: Wed, 9 Apr 2025 10:43:04 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/4] Create source symlink in perf object dir
To: Andi Kleen <ak@linux.intel.com>, namhyung@kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Markus Mayer <markus.mayer@broadcom.com>
Cc: linux-perf-users@vger.kernel.org
References: <20240807231823.898979-1-ak@linux.intel.com>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20240807231823.898979-1-ak@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Howdy!

On 8/7/24 16:18, Andi Kleen wrote:
> Create a source symlink to the original source in the objdir.
> This is similar to what the main kernel build script does.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Sorry, I am late to the party here, we were just debugging why the 
"perf" binary stopped being installed in our root filesystems when we 
moved to Linux 6.12 and beyond. Turns out that this change is 
responsible and causes the following directory structure to be created:

lrwxrwxrwx  1 ff944844 ff944844      74 Apr  9 09:43 perf -> 
/local/users/fainelli/buildroot/output/arm64/build/linux-custom/tools/perf
-rwxr-xr-x  1 ff944844 ff944844    3688 Apr  8 16:42 perf-archive
-rwxr-xr-x  1 ff944844 ff944844    3688 Apr  8 15:17 perf-archive.sh
-rw-r--r--  1 ff944844 ff944844  208760 Apr  8 16:41 perf-bench-in.o
-rw-r--r--  1 ff944844 ff944844    7070 Apr  8 15:17 perf-completion.sh
-rw-r--r--  1 ff944844 ff944844  995736 Apr  8 16:42 perf-in.o
-rwxr-xr-x  1 ff944844 ff944844     290 Apr  8 16:42 perf-iostat
-rw-r--r--  1 ff944844 ff944844     290 Apr  8 13:55 perf-iostat.sh
-rw-r--r--  1 ff944844 ff944844     547 Oct 21 14:16 perf-read-vdso.c
-rw-r--r--  1 ff944844 ff944844     452 Apr  8 13:31 perf-sys.h
-rw-r--r--  1 ff944844 ff944844  876656 Apr  8 16:41 perf-test-in.o
-rw-r--r--  1 ff944844 ff944844  307968 Apr  8 16:41 perf-ui-in.o
-rw-r--r--  1 ff944844 ff944844 3333632 Apr  8 16:42 perf-util-in.o
-rw-r--r--  1 ff944844 ff944844   13959 Apr  8 16:19 perf.c
-rw-r--r--  1 ff944844 ff944844     253 Apr  8 16:19 perf.h
-rw-r--r--  1 ff944844 ff944844   23944 Apr  8 16:42 perf.o
drwxr-xr-x  4 ff944844 ff944844    4096 Apr  8 16:19 pmu-events
drwxr-xr-x  2 ff944844 ff944844    4096 Apr  8 14:42 python
drwxr-xr-x  4 ff944844 ff944844    4096 Apr  8 16:19 scripts
lrwxrwxrwx  1 ff944844 ff944844      74 Apr  8 16:40 source -> 
/local/users/fainelli/buildroot/output/arm64/build/linux-custom/tools/perf
drwxr-xr-x  6 ff944844 ff944844   12288 Apr  8 16:19 tests
drwxr-xr-x  4 ff944844 ff944844    4096 Apr 30  2024 trace
drwxr-xr-x  6 ff944844 ff944844    4096 Apr  8 16:19 ui
drwxr-xr-x 11 ff944844 ff944844   28672 Apr  8 16:19 util

While the "source" symbolic link makes sense the symbolic link from 
"perf" back to itself does not.

and later the "install" target will hit the following:

   INSTALL libapi_headers
   INSTALL libperf_headers
   INSTALL libsubcmd_headers
   INSTALL libsymbol_headers
   INSTALL libbpf_headers
DESTDIR_SQ=/local/users/fainelli/buildroot/output/arm64/target
bindir_SQ=/usr/bin
OUTPUT=/local/users/fainelli/buildroot/output/arm64/build/linux-custom/tools/perf/
   INSTALL binaries
install: omitting directory 
'/local/users/fainelli/buildroot/output/arm64/build/linux-custom/tools/perf/perf'
ln: failed to access 
'/local/users/fainelli/buildroot/output/arm64/target/usr/bin/perf': No 
such file or directory
   INSTALL libexec
   INSTALL perf-archive
   INSTALL perf-iostat
   INSTALL dlfilters
   INSTALL perf_completion-script
   INSTALL perf-tip
   INSTALL tests

I added instrumentation to print DESTDIR_SQ, bindir_SQ and OUTPUT to 
confirm they were as expected.

We build perf using buildroot's makefile which can be seen here:

https://git.buildroot.net/buildroot/tree/package/linux-tools/linux-tool-perf.mk.in

Any clue where that first symbolic link from "perf" is coming from? Thanks!

> ---
>   tools/perf/Makefile.perf | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 175e4c7898f0..d46892d8223b 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -163,6 +163,8 @@ ifneq ($(OUTPUT),)
>   # for flex/bison parsers.
>   VPATH += $(OUTPUT)
>   export VPATH
> +# create symlink to the original source
> +SOURCE := $(shell ln -sf $(srctree)/tools/perf $(OUTPUT)/source)
>   endif
>   
>   ifeq ($(V),1)


-- 
Florian
