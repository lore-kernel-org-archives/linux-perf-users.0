Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98981C6F74
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Oct 2024 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727793005; cv=none; b=JTAGbOMlSaAoMRAmoNEKqqniv1+6diDpP4tzsatFJWo5WNc2otiWarrdpmYM+Dn0Q8uN3lXzLatNX7h1xNa2kD8effbkmK1iVIGHkd4B50S2x/YHSEsyVSZ+BocUaB//giHCnVNiu7uIyT6V/GFnnZWectLM6H0Tc5YOSSgHLbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727793005; c=relaxed/simple;
	bh=+Nl1kEdwPimOPfPmlicMbcqdvXouyxBlkRlYIlQixwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnWA0gcjCxJHDLVwUgx8Dy7uKMltoIVsayvQ5vZ5d8Gq3g2B+GXcCRtLgSg78V3XhFSdw7f4s3BKxEChD2Auj97qK6F6P85mMlfMA87MFZJ89D7UWBd+zLUUmyMilmhg4SlM5JHzXgBayMClsz6E3W1DtgSXvGEcRtR+jUHQGc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UY5MNY+k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UY5MNY+k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727793002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NYxlu4wEpUycV3Br8yC3N1dH9hq1z+35+N/eS8vjAyg=;
	b=UY5MNY+k9OX8XhSI4Mdqu9xiSsAIEXPbAbPwtE/3o1j+r2Gc9W79QrzGehsAPlRHxPfO2C
	FTa8vXhiyFE0QihVbetyPtYgAIG0sPijB2IwY3UfdoxTKUjgb3YQrIWbKd5a6Knl2sKve/
	Po6tEP3mvTkCA5Lk7IDVbXdV7D7hK4Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-ihUUIuxaMROXiGPoN2tIbQ-1; Tue,
 01 Oct 2024 10:29:59 -0400
X-MC-Unique: ihUUIuxaMROXiGPoN2tIbQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF50F196C415;
	Tue,  1 Oct 2024 14:29:56 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.88])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7FD061979074;
	Tue,  1 Oct 2024 14:29:50 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  1 Oct 2024 16:29:43 +0200 (CEST)
Date: Tue, 1 Oct 2024 16:29:35 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Liao Chang <liaochang1@huawei.com>
Cc: ak@linux.intel.com, mhiramat@kernel.org, andrii@kernel.org,
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2] uprobes: Improve the usage of xol slots for better
 scalability
Message-ID: <20241001142935.GC23907@redhat.com>
References: <20240927094549.3382916-1-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927094549.3382916-1-liaochang1@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 09/27, Liao Chang wrote:
>
> The uprobe handler allocates xol slot from xol_area and quickly release
> it in the single-step handler. The atomic operations on the xol bitmap
> and slot_count lead to expensive cache line bouncing between multiple
> CPUs.

Liao, could you please check if this series

	[PATCH 0/2] uprobes: kill xol_area->slot_count
	https://lore.kernel.org/all/20241001142416.GA13599@redhat.com/

makes any difference performance-wise in your testing?

Oleg.

