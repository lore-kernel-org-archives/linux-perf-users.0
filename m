Received: from gerbil.ash.relay.mailchannels.net (gerbil.ash.relay.mailchannels.net [23.83.222.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D5348A2DD;
	Wed, 15 Jul 2026 17:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.222.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784135447; cv=none; b=eb5o8/Jiy+e2faUwj9lspm1tmIIA0NXx3mkolGkaDKEz177fdsv0A25W69NurVREg5vPmw8bzJ6nEsFDE5wpXjJAnYc7OxJDLuGqp3fuE1krz1jJ0UHNpKji/A8UE0aDc61MuqNZCLhyD8pknF+lomXKbFco9q5ERkWBwtLdDTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784135447; c=relaxed/simple;
	bh=OyN+TpyC1zFoEMeg11i4LEuEu7Wsl0F3PeEAV9ONKik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZG219/9vTJKPFxEQJCLFpFPvMYxnhVYldUjyKukLTfnaenzw6rePDsfYxLY0rMZTPk5KHiwUM4WFQ/GGECao8KjDYH6OtU+i5UGqgIagbFWdpxpfqXEdU8PvlOVN3l7tOBPu739vqFgi0DW6xM4LCRO9IPTXGlyvnrme4cDtZ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=Vnc06Xrp; arc=none smtp.client-ip=23.83.222.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="Vnc06Xrp"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id BBBC28C1F49;
	Wed, 15 Jul 2026 16:53:13 +0000 (UTC)
Received: from pdx1-sub0-mail-a258.dreamhost.com (trex-green-4.trex.outbound.svc.cluster.local [100.103.95.92])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 4E3F48C216F;
	Wed, 15 Jul 2026 16:53:13 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Print-Absorbed: 73b5ca342942a998_1784134393594_2323542538
X-MC-Loop-Signature: 1784134393594:3517504603
X-MC-Ingress-Time: 1784134393594
Received: from pdx1-sub0-mail-a258.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.95.92 (trex/8.0.2);
	Wed, 15 Jul 2026 16:53:13 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a258.dreamhost.com (Postfix) with ESMTPSA id 4h0j0m5b6Bz1056;
	Wed, 15 Jul 2026 09:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1784134393;
	bh=MV6CcYh33O7bNjia9/HsbtXHSbp9YRTPK7nDci7aeHQ=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=Vnc06XrpDmCtgmZ+CZR5sQHIeiKAR3lpljAg53WXdapceP6rUnj6YLMK99nh93i1F
	 KgRFacVblS1BgUci+0DL22dbExllRW4+uOhBiffGXrenm7T/+kwrSIL/qT3uEifTSM
	 2kU2upNW/8tNX+tKbhYcX1BJO0xaKVtaxB1VesXRpu3QUI7ymtn6fKwMgbC2z9Kfvz
	 eqnCqwWbplyhXt78rwV0N+Lm1A3SfRNooOPgsYknQrlk7bKXCyeODoQ5cdPI74He9d
	 aK49PkzM4C2m7Hex8SET9UvvlC9UZ1vGI4LWsx424I4hNvgtcac1PszRqGO4Kxho6V
	 Xw6HhhBy3yUnQ==
Date: Wed, 15 Jul 2026 09:53:09 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: jic23@kernel.org, will@kernel.org, mark.rutland@arm.com,
	harshal.t@samsung.com, linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 3/3] perf/cxlpmu: Support Channel/Rank/Bank filter
Message-ID: <20260715165309.qvduacwyliu4pyoa@offworld>
References: <20260713061112.105419-1-dave@stgolabs.net>
 <20260713061112.105419-4-dave@stgolabs.net>
 <alXWrWdv-5xxHh4P@MWDK4CY14F>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <alXWrWdv-5xxHh4P@MWDK4CY14F>
User-Agent: NeoMutt/20220429

On Tue, 14 Jul 2026, Richard Cheng wrote:

>On Sun, Jul 12, 2026 at 11:11:12PM +0800, Davidlohr Bueso wrote:
>> @@ -621,6 +646,32 @@ static int cxl_pmu_event_init(struct perf_event *event)
>>		return -EOPNOTSUPP;
>>	/* TODO: Validation of any filter */
>>
>> +	if (cxl_pmu_config1_crb_filter_en(event)) {
>> +		if (!info->filter_crb)
>> +			return -EINVAL;
>> +		/*
>> +		 * CRB filtering (Filter ID 1) is only valid for the DDR
>> +		 * Interface, Queue Occupancy, Queue Residency and Retry
>> +		 * event groups (CXL 4.0 Table 13-5).
>> +		 */
>> +		switch (cxl_pmu_config_get_gid(event)) {
>> +		case CXL_PMU_GID_DDR:
>> +		case CXL_PMU_GID_QUEUE_OCC:
>
>Should we also validate the Event Vendor ID?
>
>GID namespace is scoped by the Vendor ID, while the groups listed
>in CXL 4.0 Table 13-5 are under CXL vendor ID.
>A vendor-specific event could reuse one of these numeric GID and pass
>this switch even though the CXL CRB rules don't apply to it.
>
>I would suggest to reject non-CXL events before the switch
>"""
>if (cxl_pmu_config_get_vid(event) != PCI_VENDOR_ID_CXL)
>    return -EINVAL;
>"""
>
>Do you think this make sense to you?

Good catch, yes this makes sense.

Thanks,
Davidlohr
