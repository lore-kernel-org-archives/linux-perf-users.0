Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7641636827E
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Apr 2026 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777540640; cv=none; b=EqF83Kl7R7645huKvEw3VGpFZ2RMMmPDWuVKUZ0I8gSE+WzohWqitP2Yp4yXS0xx4/Uy07lbSvabIANl00QMgbQF26cUFsvYw1AbMHwRSy6nsu/FLjPEAsQn9KBMfLF6+cdRXRUgaNpj0sAS/v6GXDs7p4OOJaUH0idAWMRiOtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777540640; c=relaxed/simple;
	bh=zASkZpDnp0HKO3Di+BYa06DeuxEaSIIb9mLPGirXHSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jj9khZHWd2JeorpHiokdOBPR3SfhBrnj8HkYbV/2wTSf/vB2GPSjbyK+xBMgAMuLbGgEpYdkyyu/EDg5DSHqVD9eqKqBvuNnPVGDbTePgYxwIN2aKnOXJqTq2MspEP8bUEdHl45/CKCIzrjzA0zCdGE267ERsd60HPJqkChdkEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZWdhAQVE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZWdhAQVE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777540628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zASkZpDnp0HKO3Di+BYa06DeuxEaSIIb9mLPGirXHSA=;
	b=ZWdhAQVEA/zLOk7Zv9+ds0/N9mAqYQv2aiQb8gjyekjmuYMBWoNgd4zn1HJ0PlHqp5BFrw
	VSbjkrpqssWJqOqxFtYYcxOT4Ne00k0NVyNAUSkXwhT9CTlALPAEPUgp29AMAAVlbcXnU4
	zo4jGMqGnI84r2r77bTUYbF5LmUJDLM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-jvU-4sD1M2-nzrBsuwhr_w-1; Thu,
 30 Apr 2026 05:17:04 -0400
X-MC-Unique: jvU-4sD1M2-nzrBsuwhr_w-1
X-Mimecast-MFC-AGG-ID: jvU-4sD1M2-nzrBsuwhr_w_1777540621
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E4C01800358;
	Thu, 30 Apr 2026 09:17:00 +0000 (UTC)
Received: from fedora (unknown [10.44.48.22])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 48D911800480;
	Thu, 30 Apr 2026 09:16:51 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 30 Apr 2026 11:17:00 +0200 (CEST)
Date: Thu, 30 Apr 2026 11:16:50 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Daniel Walker (danielwa)" <danielwa@cisco.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Darko Tominac -X (dtominac - GLOBALLOGIC INC at Cisco)" <dtominac@cisco.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
	"xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH] mm/madvise: preserve uprobe breakpoints across
 MADV_DONTNEED
Message-ID: <afMeAs6upm8kLCYb@redhat.com>
References: <20260429131522.4049054-1-dtominac@cisco.com>
 <889e4186-9f75-45d3-bd9a-1c90b218a635@kernel.org>
 <afIiqR5CqYRId0N0@redhat.com>
 <afJz3l6435DHLorn@goliath>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afJz3l6435DHLorn@goliath>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 04/29, Daniel Walker (danielwa) wrote:
>
> Shouldn't there be some sort of compensation or notification for this, or is each person that
> hits this suppose to just scratch their head and send a patch that's rejected?

Not sure... uprobes assumes that it owns the modified page and nobody
can modify/unmap it, including the probed application or debugger.

But may be MADV_DONTNEED should not set zap_details.even_cows == true
by default ?

Oleg.

