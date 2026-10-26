Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007926;
	b=wjoBJDmsd54lAnyLQHpULxQe1RaHMjEiH9jUjFaMqh73Mp/SyhmkpgJF5TtAWr5YHJyv
	 54XTWF4bBcu9ITkLtVD4PkevKPBPZ9826qpnvZX2oBJ4yOPVgJEF2E55fDVAZypkvUWSz
	 PaHHRUZ6CPDNoVOdtI9THopzVohSQ/MxMmrHfwgC8RTtbshUjZFAEDRPcE9kd50FAiS1w
	 tBpoBVHcvRW0Y6zRB6opBB3Dx+S1bM/LxGzAgcBHz9cBg3GbN+wlsGhXlB8bL1tULoevE
	 BKPUJWPQMqoRVw3lIia8ms95rCdXS2PSVxNrBg7uRb6KXtZ5o2BeuvYD/JmGaVE5jWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007926;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=OxqCDFNDcVrCibYsLviO4SvUbmAgApQDj/6HsjdxJ9k=;
	b=yOBO8W9sjdERuVbCGpQYpo6mdQIEEB1nbXLzpizlR8s8RDlEVhZkthyiDvmzDPecwUym
	 zoTME0Dzbg/BdqVNCeEI7tEQPF3SYKCrBMc/DGqHHkeW0crPuNBUSWYQRt5SSvpnzn4XF
	 CkxQlJEo6BIKC/9crsxVoo6aMwopRPdSZTG9WYeMQ3uls0kXXRU3frJOE7KNyn98sfhch
	 b6YFUuTkbQQWPNMhGBAxwelDQLvkKX3Q9vBnkQT4FodeovRa6/VODs5MDHmHn1EkBcEao
	 lmKPltzoaWUhr2aTmuVyMlS+kuvBPzzlZxoawj885OoB+4j4K//itJyrCoUXbNWt89w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ow3ZlImR;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31C9606A31E
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 09:45:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F31C9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ow3ZlImR
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48bbb06e746so1376331f8f.3
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 02:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793007924; x=1793612724; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OxqCDFNDcVrCibYsLviO4SvUbmAgApQDj/6HsjdxJ9k=;
        b=ow3ZlImRoLAIEZneKyfcOu3h6HDCLEChKMiLYOtQqK2HRydILGjO+5CaDdGGn/ToaE
         PYpyKaIGca/z/yv0rXB0ZK9LmFCc88nBbKAUIhn3P7ZycFuyqgkREWuydPabsd6KBM4V
         Fkyfah/yPOPOwODiaeGY99ymFoVGGacrgDfDSDV6cvwUYQ4sSlsF/ZQY8r3NaiWr45/R
         DjYOLvBAkMYrw08wIpzj31JCf+H4V/Mq4seZzf0dIAlHcI6pjcs4rjN3St3ayxBsRql4
         oC2CibQXa/oGWHfEZvR4LFlLvMMXkdRacCkPFqQDMUfxrfKuToYGVU6CkBdBXRuPY7bK
         ucgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793007924; x=1793612724;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OxqCDFNDcVrCibYsLviO4SvUbmAgApQDj/6HsjdxJ9k=;
        b=y6jcvELhXGL8hgmgFB7u6QHd7zK9zu1fBurn2GF98teH9NCmsSNxPdF8wJQW+EksK3
         tgaSsfBjJe0bqSUJwdN8eqxK5axq4dNr/t+73uY2LBSuCS0E/KddJnjYoCiVJYjGRHga
         rIyiCavALYELMLY3yMlDiVOtelKWfUVuiPX+jW9toSMT9Gx7kLsUIHC0/uKCh/gNL9uZ
         kK7INZTqqKetvRaBn9IIPptUbXKHIsGI9kPaD4z1oHodAMmenUuioDVg3Y8PfFUvoJoV
         zmhic4GqDT8xHRMV0Xx2GbL7bkuBIhsa2J2/Wd3zLx6QdJEc/NBoC+TLWGgCYmdag8lm
         Ul0w==
X-Forwarded-Encrypted: i=1; AKwUvBw9898cMS2/1MrzXnsirafL7VXRpyulpBeqpjryuB70cKyQEPqjhjNnsvzvo/9Eivg9G77HiCiinMe+/r7ltr7/@vger.kernel.org
X-Gm-Message-State: AFq9FYIxd9tvb5hzKsmvrr4rheVg1udiAOwx1kMJRW4LauziA0mmPG7M
	XtDpXV2BecM6FA9WQjrf6XpIaj6L1NV9kPxI+FDGzCam/lAtKZC82OFonWWtQIRix6s=
X-Gm-Gg: AYBFou0J6yZGRyywVDr42oIk5XjGFR0NJw72QscdOWquWapVYgbqwAAwKW+uIJqyMjy
	r/GkHQCkKBt9RPQ7oHRIXyXrFHJsEuCGpFMYC1npr6cc/lucGuByQimdwLQoVEuaWjZQzRIYq+P
	Yw2hdbttwfLcJHh8OxpHHkRafw/3BXgAT3AvqrIHwLMD2iKSWZFMS2zMLpilU9nbZLebb8lhbJ3
	FmHkdHkIk0zZK3XH0xpd1v7flNcH1zes+zS3kHnWANm47rKf1e0TjVg0rHbGuWIIES7tv90siMH
	4kY3jQ+0KmbvyyEgm/G8WSPpOL9ApYMc0Dot88xoSmB1FA1gDkimlW1Xa11uMQtuHhNXvqG5RjP
	9v1wWTH26/BpDY9DIJBexuE+3/9Utdq9x/D3im9p5WrYD2SNQwfRiASblTt16wnvhchHbj7nTMj
	ZgD3fvtj5glFYXd4jMG020JpcOqPavpQZWdZE/IKcPqmgTk63eg/9Eys+53zKYfr5f8P750xkrJ
	imaBYiQincpjHewW8cL43jVPMKw2Vges2zLU/qc7bYhjArEDKJf8MDR3JfI
X-Received: by 2002:a5d:4fd0:0:b0:48a:f59f:8b70 with SMTP id ffacd0b85a97d-48e3eb9fc55mr7288327f8f.46.1793007924239;
        Mon, 26 Oct 2026 02:45:24 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3c5bsm16044979f8f.9.2026.10.26.02.45.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 02:45:23 -0700 (PDT)
Message-ID: <c89d4824-eec4-4330-a700-65b936d8fac4@linaro.org>
Date: Mon, 26 Oct 2026 09:45:22 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] coresight: syscfg: Match feature capabilities
 separately from device class
To: Amir Ayupov <aaupov@fb.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, Shuah Khan
 <skhan@linuxfoundation.org>, Daniel Pereira <danielmaraboo@gmail.com>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
References: <cover.1792907332.git.aaupov@fb.com>
 <cover.1792989860.git.aaupov@fb.com>
 <6fd94860b3c13c0ddc1a5184d5d9331edc27d9f0.1792989860.git.aaupov@fb.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <6fd94860b3c13c0ddc1a5184d5d9331edc27d9f0.1792989860.git.aaupov@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/10/2026 05:48, Amir Ayupov wrote:
> A feature loads on a device when the two share any match flag. That works
> for device classes, where a feature wants any one of them, but not for
> capabilities a device may or may not have: a feature that sets a class
> and a capability would still load on a device of that class without the
> capability.
> 
> Split the match flags into CS_CFG_MATCH_CLASS_MASK for device classes and
> CS_CFG_MATCH_CAP_MASK for capabilities. A feature now loads on a device
> that shares one of its classes and has all of its capabilities. Check
> this once in cscfg_load_feat_csdev(), which both the feature and the
> device registration paths call. No capability flags are defined yet, so
> matching is unchanged.
> 
> Assisted-by: Devmate:Opus-5.5
> Signed-off-by: Amir Ayupov <aaupov@fb.com>
> ---
>   .../hwtracing/coresight/coresight-config.h    |  8 ++++
>   .../hwtracing/coresight/coresight-syscfg.c    | 37 +++++++++++++------
>   2 files changed, 34 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
> index ae6295e308131..f04e73b91d9a6 100644
> --- a/drivers/hwtracing/coresight/coresight-config.h
> +++ b/drivers/hwtracing/coresight/coresight-config.h
> @@ -7,6 +7,7 @@
>   #ifndef _CORESIGHT_CORESIGHT_CONFIG_H
>   #define _CORESIGHT_CORESIGHT_CONFIG_H
>   
> +#include <linux/bits.h>
>   #include <linux/cleanup.h>
>   #include <linux/coresight.h>
>   #include <linux/types.h>
> @@ -30,6 +31,13 @@
>    */
>   #define CS_CFG_MATCH_CLASS_SRC_ALL	0x0001	/* match any source */
>   #define CS_CFG_MATCH_CLASS_SRC_ETM4	0x0002	/* match any ETMv4 device */
> +#define CS_CFG_MATCH_CLASS_MASK		GENMASK_U32(7, 0)
> +
> +/*
> + * flags defining device capabilities a feature can require. A feature loads on
> + * a device that matches one of its classes and has all of its capabilities.
> + */
> +#define CS_CFG_MATCH_CAP_MASK		GENMASK_U32(15, 8)
>   
>   /* flags defining device instance matching - used in config match desc data. */
>   #define CS_CFG_MATCH_INST_ANY		0x80000000 /* any instance of a class */
> diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
> index a816c22c87bc8..3ee104e94a4cd 100644
> --- a/drivers/hwtracing/coresight/coresight-syscfg.c
> +++ b/drivers/hwtracing/coresight/coresight-syscfg.c
> @@ -171,8 +171,22 @@ cscfg_alloc_csdev_feat(struct coresight_device *csdev, struct cscfg_feature_desc
>   	return feat_csdev;
>   }
>   
> -/* load one feature into one coresight device */
> +static bool cscfg_match_feat_csdev(u32 feat_flags, u32 csdev_flags)
> +{
> +	/* The device must be in one of the feature's classes */
> +	if (!(feat_flags & csdev_flags & CS_CFG_MATCH_CLASS_MASK))
> +		return false;
> +
> +	/* The device must have every capability the feature requires */
> +	if (feat_flags & ~csdev_flags & CS_CFG_MATCH_CAP_MASK)
> +		return false;
> +
> +	return true;
> +}
> +
> +/* Load the feature into the device if it matches, otherwise skip it. */
>   static int cscfg_load_feat_csdev(struct coresight_device *csdev,
> +				 u32 match_flags,
>   				 struct cscfg_feature_desc *feat_desc,
>   				 struct cscfg_csdev_feat_ops *ops)
>   {
> @@ -183,6 +197,9 @@ static int cscfg_load_feat_csdev(struct coresight_device *csdev,
>   	if (!ops->load_feat)
>   		return -EINVAL;
>   
> +	if (!cscfg_match_feat_csdev(feat_desc->match_flags, match_flags))
> +		return 0;
> +
>   	feat_csdev = cscfg_alloc_csdev_feat(csdev, feat_desc);
>   	if (!feat_csdev)
>   		return -ENOMEM;
> @@ -212,11 +229,11 @@ static int cscfg_add_feat_to_csdevs(struct cscfg_feature_desc *feat_desc)
>   	int err;
>   
>   	list_for_each_entry(csdev_item, &cscfg_mgr->csdev_desc_list, item) {
> -		if (csdev_item->match_flags & feat_desc->match_flags) {
> -			err = cscfg_load_feat_csdev(csdev_item->csdev, feat_desc, &csdev_item->ops);
> -			if (err)
> -				return err;
> -		}
> +		err = cscfg_load_feat_csdev(csdev_item->csdev,
> +					    csdev_item->match_flags, feat_desc,
> +					    &csdev_item->ops);
> +		if (err)
> +			return err;
>   	}
>   	return 0;
>   }
> @@ -739,11 +756,9 @@ static int cscfg_add_feats_csdev(struct coresight_device *csdev,
>   		return -EINVAL;
>   
>   	list_for_each_entry(feat_desc, &cscfg_mgr->feat_desc_list, item) {
> -		if (feat_desc->match_flags & match_flags) {
> -			err = cscfg_load_feat_csdev(csdev, feat_desc, ops);
> -			if (err)
> -				break;
> -		}
> +		err = cscfg_load_feat_csdev(csdev, match_flags, feat_desc, ops);
> +		if (err)
> +			break;
>   	}
>   	return err;
>   }

Reviewed-by: James Clark <james.clark@linaro.org>

