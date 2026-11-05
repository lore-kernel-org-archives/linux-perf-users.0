Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881504;
	b=zUmhqmjNEnHNTZ0/Wm0LNHGEm51vbjF4WZtqFSKt7vD462PDkom9mnGPBySkHUPdbYs4
	 4ejgcIpkxtOMNde9S22cZDs2SGhafZR/nGjXq2u+n+f7LFNnmbOLhsEr4DDl9sYZdJizK
	 uDqG+CyKnFpoUvcGT5alrH04+VuSah0KTk4xjubrM9piRsBehjvoN2JvKkJzGerehY8B7
	 98gz5DFFCOMtXIy2zeZ6cOSaszXvxZtxts4UH+wLQELCtJdl9yWG+04rdxjSZoYHqy/Al
	 i8j8iMt4lQAdQLnoV9ACKWiG0R/ewwMDAOJg6pgulFI6rkYj54KcGOdDFx2spWSsywQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881504;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=WCI67nW/m0Se+hAdbILYxBYbZp7So82hMXgOTyc/3Go=;
	b=IyH/VwjNjTLZyWjOTdWJf6RzQVNZSt//6ZIy/GLa3ybXrazEGsf9QBDeiOpuRKf7GKCb
	 BG9dsBzMR9aSOafh5z6Nl1/qU7wl8ADVTkWQufSWNBRJ+OPaMd7sorCvEQWo5OpgwcdcJ
	 rDSVkwStqdCGFv5NeLzqqkmVAj3f2bfo/NP26JFgl3eSyE9rDZHdE2jw9FEHTXEEJD5gm
	 Db/pABEXgwSeGLNwXWn3jdJKYmwiyqptAENOqLkvLk/oB1z8MvTYX/YuswKjIwHOlCVC2
	 ZHj40h5LDgIo6kb/sayifrx2/CkIrTE8RPHKxZJlCbU8taLEFnnt0KfJo51xufogcww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=o+wjKA8n;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574A3606A329;
	Thu,  5 Nov 2026 12:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 574A3606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=o+wjKA8n
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8527919F6;
	Thu,  5 Nov 2026 04:24:59 -0800 (PST)
Received: from [10.2.197.99] (ewhatever.cambridge.arm.com [10.2.197.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 660E83F673;
	Thu,  5 Nov 2026 04:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793881502; bh=SQl66A6bDNzs1tIhc+4XgtWG3rrRdvF5c5Ea4qqQNKM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o+wjKA8njcOyhB5nW7vgRC68CErXR8/dMPbAboNhIo8wy0bkUHaC9LcEywEp4blS7
	 FHm+KtR5irptZcE0HJR5eBivWjzQTXPIHdVoisgrRXpX58c2fZA0gNdXkqHm89mieh
	 R500CjJBRC7Cy4y+hHmIebVA1SEV8fnh6hGu9xOs=
Message-ID: <ca99c6be-cb92-4d2a-816d-a15624af96b6@arm.com>
Date: Thu, 5 Nov 2026 12:24:58 +0000
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
To: Amir Ayupov <aaupov@fb.com>, James Clark <james.clark@linaro.org>,
 Leo Yan <leo.yan@arm.com>, Mike Leach <mike.leach@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, Shuah Khan
 <skhan@linuxfoundation.org>, Daniel Pereira <danielmaraboo@gmail.com>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1792907332.git.aaupov@fb.com>
 <cover.1792989860.git.aaupov@fb.com>
 <6fd94860b3c13c0ddc1a5184d5d9331edc27d9f0.1792989860.git.aaupov@fb.com>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
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

Please could you address the following comment ?

https://lore.kernel.org/linux-arm-kernel/82adee03-a169-4106-99f2-7624a4926037@arm.com/

Cheers
Suzuki


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

