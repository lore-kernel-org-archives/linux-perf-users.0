Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F265EEB3;
	Fri,  7 Aug 2026 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786119099; cv=none; b=b8QVU0DiPVLdRempyKECuFPz6UnsMLyS3kIHcviEQ7U+uI0AQf7TnY7ucfqSGGm9P1cMJW6CS+UbNXgPu1tLniuQ/hS6KeDS/W+Rke5hEwV6t4l6kL8+mdTtY4HbGFMwV1Jejs76990dQ6sDfzd42RHn35mzTMGU5uA9V7WQQXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786119099; c=relaxed/simple;
	bh=o1D/R4hBctHnMgA6ZrScYqZJuZw3JzniBUalCh6KVoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BENSAfYSA1hGhygznNWLYvnyMZZcm5WfOk4TuLV5Mrf/n9OEBvy6O2tPGHHz/v+SQ+X5FOeLoWR7wkjqXej2QwwkMhIQs9h8hqXGELjlFqmeM0LKzfgX3Dvz+Rz4/cnm8Ta9oQZHNNSP7VGZVfG02C+H9i+X4z+JkQ35h/N6nlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k7WTPTuj; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k7WTPTuj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IokHPtbaHLHDx61gt6Lm0lTIK941JgBywII7c5fQkxk=; b=k7WTPTuj4cbU8D3NmkdfnNLOyL
	J9blYVUAfs0dhFOG7YAIxESR2M8N3tNl+yhs+rwT+Gmif7zr84ELxGW+PZ+eueTE7cI9O4cAEdz6i
	T3MGJ0proIzOOtBUTFZLGSuNMHcbjXo4sLRVT0SgrxHsTkPD3UuoskLSdiPSVS1n8ySVSkhrHj/kB
	pwII+coKhSCStowNqUH0ubVeFOp7u/K5mkNRzjZl9Ra6NxCOwZfXPDn7dTjGHBWHgSL/bfuptcrj3
	sXz9KTNoU9zJvDja7unrNOWYL10vC0pg1RX+je81NOGfr2pH3qZxmP3e3qqEV+z3JArNtsj9YrSiS
	9KOB4C7g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wsNAF-0000000CWAP-27l7;
	Fri, 07 Aug 2026 16:11:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A385F30019A; Fri, 07 Aug 2026 18:10:47 +0200 (CEST)
Date: Fri, 7 Aug 2026 18:10:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/3] perf/x86/intel/pt: Fix stop/start with no update
Message-ID: <20260807161047.GV776954@noisy.programming.kicks-ass.net>
References: <20260721070254.13557-1-adrian.hunter@intel.com>
 <6f7cdb51-ac65-4ee8-98bd-1274e84ee38b@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f7cdb51-ac65-4ee8-98bd-1274e84ee38b@intel.com>

On Wed, Aug 05, 2026 at 02:22:30PM +0300, Adrian Hunter wrote:
> On 21/07/2026 10:02, Adrian Hunter wrote:
> > Here is a fix for Intel PT.
> 
> Any comments on this

Looks okay, let me feed it to the robots.
