Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DC21F943B
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Nov 2024 09:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578081; cv=none; b=KyufOJGi2wL1jYVQU+sMtxpVw1mz61fZRPSWz95QpgllMfwb5zJ3JpYtLEvt3lTwGMVfb4SWbfUqkhwRT/ULcNqxIDOeNvSRmcmyeR1PiOWAQSc8EYdhTDICVF2uzEGwacKGX8ds3vlsXW0TJ3poYnBgJdA15RoxnH5iGQq6cM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578081; c=relaxed/simple;
	bh=B7HGtwO6qOhKivfQzUDeVPvY8MX9AWPPzn7Q3nxSq6A=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=JBOnu9QFxaIw1WqrL+A8xI591QLeLl0X/mt+ZPw9iGaLOtkw5o4QPPlCWcvHR4rXtIyMZoDpFvGzO9Xk8dbEfOPcVjXFTLkT4SpJ9CO4RjtVB8EOC2NwcgDcpPCR3gm+PydUL+RxEIRv0mQA7rjrxYvBMUPX4Z14xOne7vrFWBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LPT3DA3D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPT3DA3D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731578077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=S+hwUO5RNhfWJ4HRcQ8BdpZrN0FrwrP/iZb+FWAikfQ=;
	b=LPT3DA3DwDwKz2UVmptxcfJese4177m5tv1Wq9IvepV3RxjuGMAIq9VTixGQjjiMb8VYW0
	d/4Z7kE6Lk0qelSLEAwhj4tmmORSfbwpo1hBBDHPM2sirrYhY9IjxqmsUmke6sXVMAahT+
	j4mAZu+7xVH+6vnFaQXqTd2x2GiBtvs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-T-ufEYI6Mpqyi0rgL2uCXw-1; Thu,
 14 Nov 2024 04:54:34 -0500
X-MC-Unique: T-ufEYI6Mpqyi0rgL2uCXw-1
X-Mimecast-MFC-AGG-ID: T-ufEYI6Mpqyi0rgL2uCXw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 70826195609F;
	Thu, 14 Nov 2024 09:54:33 +0000 (UTC)
Received: from Carbon (unknown [10.39.208.40])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B8BB719560A3;
	Thu, 14 Nov 2024 09:54:30 +0000 (UTC)
Date: Thu, 14 Nov 2024 10:54:26 +0100 (CET)
From: Michael Petlan <mpetlan@redhat.com>
To: kan.liang@linux.intel.com, alexander.shishkin@linux.intel.com, 
    adrian.hunter@intel.com, linux-perf-users@vger.kernel.org
cc: qzhao@redhat.com, vmolnaro@redhat.com
Subject: Intel Arrowlake and hwcache events
Message-ID: <ea7b2c27-7512-f412-32c0-3a247fd930f9@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hello!

Qiao Zhao (CC'd) has found out that there are no hwcache events available
on an Arrowlake system he was testing perf on. We have found out that it
does not work even on 6.12.0-rc6+. Are there still drivers that haven't
been merged yet?

Happens that nothing matches in this loop:

int print_hwcache_events(const struct print_callbacks *print_cb, void *print_state)
[...]
305		for (int type = 0; type < PERF_COUNT_HW_CACHE_MAX; type++) {
306 		for (int op = 0; op < PERF_COUNT_HW_CACHE_OP_MAX; op++) {
307  	 		/* skip invalid cache type */
308 			if (!evsel__is_cache_op_valid(type, op))
309					continue;
310
311			for (int res = 0; res < PERF_COUNT_HW_CACHE_RESULT_MAX; res++) {
312 			char name[64];
313				char alias_name[128];
314				__u64 config;
315				int ret;
316
317				__evsel__hw_cache_type_op_res_name(type, op, res,
318													name, sizeof(name));
319
320				ret = parse_events__decode_legacy_cache(name, pmu->type,
321													&config);
322				if (ret || !is_event_supported(PERF_TYPE_HW_CACHE, config))
323					continue;

Thanks,
Michael

