Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948553D3309
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Feb 2026 12:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770294584; cv=none; b=kUOZpY5K0pQiM4N5bAoWgPkkCpArtP379bS/ic1ktz2FmRF5nU3wuny6WM7OrBglMWeaVDK+dYqq3aLDsYmoU6s6ZoXJqsI8uWhc7QxHgGPboJNNoZxerRUQWDtMVWgJYdWkAS0SLPvUmCtpVIbANd+lorsm8UINuwnm2lr4XhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770294584; c=relaxed/simple;
	bh=SmGwsreFC875e2XkP97W/boxhAVimJd+kAYCDyQkBOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSbj8MTh3eZQzrvf6O0m5/z1H0HLFJu8XapeRfheTYkshMuazQDKHJGdfwbq3d+D+Q/Q1rIvgng6e1PCfb2urVwkijFwuYp0GE7hY7rO4VyfPV3k2dePGeeqV0h61iu+CCGxoGJH3dkBX0tnmT8Zj0b6yfp+jDXPotDVPgjW/Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ln5Jah7R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ln5Jah7R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770294583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SmGwsreFC875e2XkP97W/boxhAVimJd+kAYCDyQkBOE=;
	b=Ln5Jah7R4AcYDYRr/vvwWEOY1vXM9L67CfwltrLkKBEQ3LMqr3+hkSmZoyiy4VNJxoWcKc
	zNFT7+3u7FpmsG4xag1w+Dbi4lfZ4RXjdcn+zZXPXERLkF98NkiF74W/fqTpuRZiBY3t+j
	KIE7J1xCVkByiM580N4h2i6QWBq1zro=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-1-HKa2yFP1ChMu5ZPDHAUg-1; Thu,
 05 Feb 2026 07:29:40 -0500
X-MC-Unique: 1-HKa2yFP1ChMu5ZPDHAUg-1
X-Mimecast-MFC-AGG-ID: 1-HKa2yFP1ChMu5ZPDHAUg_1770294578
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F127E1800473;
	Thu,  5 Feb 2026 12:29:37 +0000 (UTC)
Received: from fedora (unknown [10.45.224.8])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B9532300DDA1;
	Thu,  5 Feb 2026 12:29:31 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  5 Feb 2026 13:29:37 +0100 (CET)
Date: Thu, 5 Feb 2026 13:29:30 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Carlos =?iso-8859-1?Q?L=F3pez?= <clopez@suse.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	"open list:UPROBES" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] uprobes: replace deprecated kmap_atomic() with
 kmap_local_page()
Message-ID: <aYSNKqr2rmO7dHBm@redhat.com>
References: <20260205105725.298340-1-clopez@suse.de>
 <20260205111208.GK232055@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260205111208.GK232055@noisy.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 02/05, Peter Zijlstra wrote:
>
> On Thu, Feb 05, 2026 at 11:57:25AM +0100, Carlos López wrote:
> > kmap_atomic() has been deprecated for a few years, and kmap_local_page()
> > should be used instead, so replace it. Since the uprobes code relied on
> > kmap_atomic() disabling page faults to access user pages, add the
> > required calls to keep the existing behavior.
>
> Are those pagefault_disable()s really needed here, or is this just
> cargo-culting?

No, I think there are not needed.

And the (already in tip) patches from Keke do not add pagefault_disable().

is_trap_at_addr() does pagefault_disable() because it is called with
mm->mmap_lock held.

Oleg.

