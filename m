Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0598F35C1BC
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 15:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777476287; cv=none; b=L/npjp9gwuWIqygahy7W7ilRFuufhXMIcTD36veVSX9ieU7oCGfFfE2JOEsA6zlaUO2lnrmrW8brTT57B+2vLs09otm9AfF2XBns09gghVU6V1szcGvt5ORbvVQvkoCXWBPP4e6J/DosXySW1Em8vfBxDwtEm2zD+zI9GEwFXlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777476287; c=relaxed/simple;
	bh=jTx+THxx2aXF7hL7UE4UgFKEQQ3AvKKmFVMBT+G5Og4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0BjzPD9cuE8FSim+X7DhAmhuuQa+0DHxlanGVF1fjLbg76TGfdY0LMA4ghEGofBxXKxGkCA3hCArIfLF7xVUASSnAsbml35YHsR5s7HCSY6hcznCRX66GYY81Ie6r3RIaIDk4JXcUHite5w5e/LM58KiM8VdCT49QMdC3CYK9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CaiSu+Nc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CaiSu+Nc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777476285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZAXYezcr0Iy1hB7ntqgzjazz7eZ4Gyavm9fB/UWyNQQ=;
	b=CaiSu+Nce63Kzlu/BrEjKx0dfvNEJKiHc+dF0V5pk7O6VNRzLfr8j3d9fboy8KR4ZMGasN
	3P7wIMVwV6WU5BcPyHtfAKc9cjdUYlSMnjfvZfbOYaUlefHW3EUkCe5jAcaOnqAknVYwuc
	qxkf2DqcmrYnNFz9d6wo8VL9fSSG9ak=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-JepyDPiiNe-cYpKsZOgmKg-1; Wed,
 29 Apr 2026 11:24:41 -0400
X-MC-Unique: JepyDPiiNe-cYpKsZOgmKg-1
X-Mimecast-MFC-AGG-ID: JepyDPiiNe-cYpKsZOgmKg_1777476277
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03E3A1800451;
	Wed, 29 Apr 2026 15:24:36 +0000 (UTC)
Received: from fedora (unknown [10.44.48.22])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D6F7A180045E;
	Wed, 29 Apr 2026 15:24:26 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 29 Apr 2026 17:24:35 +0200 (CEST)
Date: Wed, 29 Apr 2026 17:24:25 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Darko Tominac <dtominac@cisco.com>,
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
	xe-linux-external@cisco.com, danielwa@cisco.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/madvise: preserve uprobe breakpoints across
 MADV_DONTNEED
Message-ID: <afIiqR5CqYRId0N0@redhat.com>
References: <20260429131522.4049054-1-dtominac@cisco.com>
 <889e4186-9f75-45d3-bd9a-1c90b218a635@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <889e4186-9f75-45d3-bd9a-1c90b218a635@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 04/29, David Hildenbrand (Arm) wrote:
>
> On 4/29/26 15:15, Darko Tominac wrote:
>
> > uprobe infrastructure does not re-instrument pages on individual page
> > faults (uprobe_mmap() is only called during VMA creation, not on
> > page-in), the breakpoints are silently lost once the discarded pages are
> > re-read from the backing file.  The probes stop firing with no error
> > indication, and the only recovery is to unregister and re-register the
> > affected uprobes.
>
> Right. Don't MADV_DONTNEED uprobes, just like you are not supposed to
> MADV_DONTNEED debugger breakpoints/set data etc. :)

Agreed, thanks.

Oleg.

