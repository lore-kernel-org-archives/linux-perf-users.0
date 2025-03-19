Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D677D1E1DF4
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Mar 2025 12:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742385683; cv=none; b=QDeg6VXIH1ufzO2A+Fsh1+J/sniemSKh6KvqcePYlZThX9YdwIu1SFGUZpLdaBiEIsnXZS0P0bagUfrJ1dp7Ggx1m8aL5Qs5sICL3relXNahQAuc5U+P32lkc+cCtaK/6WCAPoOZgujpUkrDl1lusoj3VaNkr+7IMMbOUlaoGPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742385683; c=relaxed/simple;
	bh=X0xBK3bLzDuZkB26jELnSzSPI6NgmsFq0dxeZWxGeIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNm7rch1gRzcf8tBnIa3k7C82VehcKlFHk/NQgGhpg7eGB8uK/FFtRaBGV/vghu7fLJv3nAInZ1WSLABB66zWLiqAkJqkR5No4IUDqrKmTo4AY++uFguYqlumHUZ+3wwq/1siflW75TT/SEgU3CMbMzTl+XfRxrQe5AIYf62jsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PlrpLxmF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PlrpLxmF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742385680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YqwTqw0LkuMJVhI7nUbav86stM0t9airgBDOJOw1FA0=;
	b=PlrpLxmFnPY4xRbCXoW1F+lGgpgRB5Now2GST7a6VTHqVcpaOXaQ+9UuICx08WVJPhXjDM
	NXvmIhDx3Kx/d3hNoifuQoPQiFxriF2yOzNwQkFBlrsIuQiuczcRgeNzQd53F5is9L1OU8
	kay1JUXPUzyB2iCUDwK0lT6wnMoPmzY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-Ep91YsP_MAa5nA-2OQLbTA-1; Wed,
 19 Mar 2025 08:01:16 -0400
X-MC-Unique: Ep91YsP_MAa5nA-2OQLbTA-1
X-Mimecast-MFC-AGG-ID: Ep91YsP_MAa5nA-2OQLbTA_1742385673
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC50F180AF69;
	Wed, 19 Mar 2025 12:01:11 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.12])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5D85E1801751;
	Wed, 19 Mar 2025 12:01:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 19 Mar 2025 13:00:39 +0100 (CET)
Date: Wed, 19 Mar 2025 13:00:29 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Tong Tiangen <tongtiangen@huawei.com>
Subject: Re: [PATCH v2 3/3] kernel/events/uprobes: uprobe_write_opcode()
 rewrite
Message-ID: <20250319120028.GA26879@redhat.com>
References: <20250318221457.3055598-1-david@redhat.com>
 <20250318221457.3055598-4-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318221457.3055598-4-david@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 03/18, David Hildenbrand wrote:
>
> +	if (unlikely(!folio_test_anon(folio))) {
> +		VM_WARN_ON_ONCE(is_register);
> +		goto out;
> +	}

Don't we need folio_put() before "goto out" ?

Other than that, for this series:

Acked-by: Oleg Nesterov <oleg@redhat.com>

