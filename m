Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325AA15AE2
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Oct 2023 09:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fy+rN/Cv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254C1A2
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Oct 2023 02:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697622648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NLpCBnDLvfXNYYi67xC1Ssv/noZY9gzp0KbFkKx9aOs=;
	b=fy+rN/CvR5XUaa1qDYOMGhof1d+jo+JA1/V36CH0Crt615GDjVVx/6HqktnBUBbtfmDyWE
	GAHgylWpyq+xQNHl05iDNBouJwporJXnV4ivZY4S28eiePzwcY4Fua6FpSbn6A01d5H/vi
	ZXrZNUYgc/oYIQzNFuvl+yNLum0S+A8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-mTKdlSS-P3adO1NlkGiYxw-1; Wed, 18 Oct 2023 05:50:37 -0400
X-MC-Unique: mTKdlSS-P3adO1NlkGiYxw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7788fa5f1b0so117838785a.2
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Oct 2023 02:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697622635; x=1698227435;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NLpCBnDLvfXNYYi67xC1Ssv/noZY9gzp0KbFkKx9aOs=;
        b=vTbIiqrV1ke4F+sAA+lyTVMH+CbuXgdADLWnHM/VUf6LU655sbX5J4K8/xevtcuxzq
         SMlIuPrqvD4sKzGRf7UmYsX56CAxgE2t1Ce+dME6if9Sz53tZOPozwO/ZAM/l5ql5l8N
         ARqOUaLNQQF0BAa89nZjiSgbFOP35nb7ntBCUNMZ6ax7G1w22AxjtT6MmHeKt+yKkfoY
         hd6yw1aF8l+J1q1sxD7rklIwQl83KKesFLNYUsN2GmkUcDZAt5OgHwGQWezfDKJJQKMu
         Xaih1Tlmat1i6IBezqCBJA/ThcGXqKO9woCm0N7oJ49gjpufkpH7J60lAiPmpWL2BjHb
         uWeQ==
X-Gm-Message-State: AOJu0YwDRM/9zLBxC0XbUZvJXhwQ7d0OlyXW6QOQbexfeos8LTVCDsLK
	MPIdBofALZUB305YMA4ZqWMQ+BeqyQP6q8SBm/CUU5oTDJhY5idUuhN1iW8JrhCpE8XcWfkVWv1
	RaPvZfkC2raFmwDN3t4NsD/92c0qtgeabFtDQVg==
X-Received: by 2002:a05:620a:25d3:b0:774:1d2c:c412 with SMTP id y19-20020a05620a25d300b007741d2cc412mr4926118qko.44.1697622635299;
        Wed, 18 Oct 2023 02:50:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJzybtWarVKQQszbGViLQUiJB1FoBZ7kxdl8szeiXBGLOy9SIafzQrmXJGJp4Ev7uirtyyTw==
X-Received: by 2002:a05:620a:25d3:b0:774:1d2c:c412 with SMTP id y19-20020a05620a25d300b007741d2cc412mr4926097qko.44.1697622634967;
        Wed, 18 Oct 2023 02:50:34 -0700 (PDT)
Received: from [192.168.43.95] ([37.170.189.211])
        by smtp.gmail.com with ESMTPSA id de26-20020a05620a371a00b007743446efd1sm1342740qkb.35.2023.10.18.02.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 02:50:34 -0700 (PDT)
Message-ID: <4aa5d142-462f-24d9-8f13-ead19c15ae99@redhat.com>
Date: Wed, 18 Oct 2023 11:50:28 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/5] tools: arm64: Add a Makefile for generating
 sysreg-defs.h
Content-Language: en-US
To: Oliver Upton <oliver.upton@linux.dev>, kvm@vger.kernel.org
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Jing Zhang <jingzhangos@google.com>, Zenghui Yu <yuzenghui@huawei.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, James Morse
 <james.morse@arm.com>, Marc Zyngier <maz@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Adrian Hunter
 <adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>
References: <20231011195740.3349631-1-oliver.upton@linux.dev>
 <20231011195740.3349631-2-oliver.upton@linux.dev>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20231011195740.3349631-2-oliver.upton@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Oliver,

On 10/11/23 21:57, Oliver Upton wrote:
> Use a common Makefile for generating sysreg-defs.h, which will soon be
> needed by perf and KVM selftests. The naming scheme of the generated
> macros is not expected to change, so just refer to the canonical
> script/data in the kernel source rather than copying to tools.
> 
> Co-developed-by: Jing Zhang <jingzhangos@google.com>
> Signed-off-by: Jing Zhang <jingzhangos@google.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  tools/arch/arm64/include/.gitignore |  1 +
>  tools/arch/arm64/tools/Makefile     | 38 +++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
>  create mode 100644 tools/arch/arm64/include/.gitignore
>  create mode 100644 tools/arch/arm64/tools/Makefile
> 
> diff --git a/tools/arch/arm64/include/.gitignore b/tools/arch/arm64/include/.gitignore
> new file mode 100644
> index 000000000000..9ab870da897d
> --- /dev/null
> +++ b/tools/arch/arm64/include/.gitignore
> @@ -0,0 +1 @@
> +generated/
> diff --git a/tools/arch/arm64/tools/Makefile b/tools/arch/arm64/tools/Makefile
> new file mode 100644
> index 000000000000..f867e6036c62
> --- /dev/null
> +++ b/tools/arch/arm64/tools/Makefile
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +ifeq ($(srctree),)
> +srctree := $(patsubst %/,%,$(dir $(CURDIR)))
> +srctree := $(patsubst %/,%,$(dir $(srctree)))
> +srctree := $(patsubst %/,%,$(dir $(srctree)))
> +srctree := $(patsubst %/,%,$(dir $(srctree)))
> +endif
> +
> +include $(srctree)/tools/scripts/Makefile.include
> +
> +AWK	?= awk
> +MKDIR	?= mkdir
> +RM	?= rm
> +
> +ifeq ($(V),1)
> +Q =
> +else
> +Q = @
> +endif
> +
> +arm64_tools_dir = $(srctree)/arch/arm64/tools
> +arm64_sysreg_tbl = $(arm64_tools_dir)/sysreg
> +arm64_gen_sysreg = $(arm64_tools_dir)/gen-sysreg.awk
> +arm64_generated_dir = $(srctree)/tools/arch/arm64/include/generated
> +arm64_sysreg_defs = $(arm64_generated_dir)/asm/sysreg-defs.h
> +
> +all: $(arm64_sysreg_defs)
> +	@:
> +
> +$(arm64_sysreg_defs): $(arm64_gen_sysreg) $(arm64_sysreg_tbl)
> +	$(Q)$(MKDIR) -p $(dir $@)
> +	$(QUIET_GEN)$(AWK) -f $^ > $@
> +
> +clean:
> +	$(Q)$(RM) -rf $(arm64_generated_dir)
> +
> +.PHONY: all clean

