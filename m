Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC681EF377
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Mar 2025 14:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395928; cv=none; b=mwaPkDxSKkw42QWVcTozsKDXdWEzVf9QarDzmFT/d3Td9o7a9W/NBJioHv/oSLh9vMaaedHKnwvICwd+UW1YK+ndslfJ3td85uidIMUzxsyWspGHQm/vYQJIMTrxw9C66owxkydCjcEdhZIPjWZjLgDfjbuow1TbjPszH4c+8Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395928; c=relaxed/simple;
	bh=fmThr+0j5ZXRTB6Jpny73eJBulXT9fTCmES60M34KXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZYgZ6jKozd/k8OBoQVJ+ywXtM91rQzfnG8osS41u3pPKv55l3M2qri6f8tGKatDAMMxpnmkwa6C3IlzxpPFDFpU7qAAAy0eFPrpkSCGfTBtK7Qy68PVSXAEVoh98KkDemW65wTpU65RweJh30WbxTTctjoc8xSKw8ky0X3Hf68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GTYTEee3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GTYTEee3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742395926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rwWKRC3nWivzyNEP1S1vISXANNiFB9MsZAJYGEURD2o=;
	b=GTYTEee3Y/19GZXFtO7XJE0PUX/9F3U/sFXNj3dGuN5siZ6YbozIYG3sVusOGgQjdsLjY+
	aC3vDLIbQYX4cGP53xFDD+7w0SSN+GGZFL98EHiodkD7HPsvUP2r7Fu03oYlCQTzmk6F0x
	5oZ9HwozYj7yykT7G4uJi6y7k0twd4w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-y1tPtKyJNL6OPCxZd64RTw-1; Wed,
 19 Mar 2025 10:51:59 -0400
X-MC-Unique: y1tPtKyJNL6OPCxZd64RTw-1
X-Mimecast-MFC-AGG-ID: y1tPtKyJNL6OPCxZd64RTw_1742395916
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A6B71800349;
	Wed, 19 Mar 2025 14:51:56 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C5A693001D12;
	Wed, 19 Mar 2025 14:51:46 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 19 Mar 2025 15:51:23 +0100 (CET)
Date: Wed, 19 Mar 2025 15:51:13 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mhiramat@kernel.org, peterz@infradead.org, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, thiago.bauermann@linaro.org,
	broonie@kernel.org, yury.khrustalev@arm.com,
	kristina.martsenko@arm.com, liaochang1@huawei.com,
	catalin.marinas@arm.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] uprobes: Allow the use of uprobe_warn() in arch code
Message-ID: <20250319145057.GA10753@redhat.com>
References: <20250318204841.373116-1-jeremy.linton@arm.com>
 <20250318204841.373116-7-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318204841.373116-7-jeremy.linton@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 03/18, Jeremy Linton wrote:
>
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -185,6 +185,7 @@ struct uprobes_state {
>  };
>  
>  extern void __init uprobes_init(void);
> +extern void uprobe_warn(struct task_struct *t, const char *msg);
>  extern int set_swbp(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
>  extern int set_orig_insn(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
>  extern bool is_swbp_insn(uprobe_opcode_t *insn);
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index b4ca8898fe17..613c1c76f227 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -118,7 +118,7 @@ struct xol_area {
>  	unsigned long 			vaddr;		/* Page(s) of instruction slots */
>  };
>  
> -static void uprobe_warn(struct task_struct *t, const char *msg)
> +void uprobe_warn(struct task_struct *t, const char *msg)
>  {
>  	pr_warn("uprobe: %s:%d failed to %s\n", current->comm, current->pid, msg);
>  }

Oh, no, please don't.

uprobe_warn() is ugly and needs changes. If nothing else it doesn't even use
its "t" argument.

Oleg.

