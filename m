Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7643D6A;
	Wed, 22 Jan 2025 12:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737548602; cv=none; b=aDRB2DAyRv0tIYVE0EVBYM3T0omTEf/Gv10GbnFwG/A78v4hqMLtfPajt7eD/Fg71lfliL1PWF1PW46BwsSdlg3ScEjNqrXhPxibdlOCyvOvi3ZrwkANm/kyte/FWpyDN7m2xIiueVeiJBCyqa2dfGYTrqeNiBksoG8CMj67DAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737548602; c=relaxed/simple;
	bh=hPezyFKFAdrMJG6qvIV+YB4yZ3REsIUN7gmFrFDG934=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZmZw0gLPo2rzVC5lp8dAaV/nGt/DMyJ0C3os0F5j7pM1Dyj71C/RQNzFbDp88sE4q8PiN7ikEv+Bor4YD6yDkZKUL1MPTMnNJQLBs5Ai272JB6yi3q4fb3x/nwvO/1iiEpfNJOgL/hW7Wbl2ngpH+YqaBScQMjaRQZReYQ/kHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CCJvv6Y5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CCJvv6Y5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IZkr8Kn7Qz6gW0Ykx53osQ20u/ULN1bUvrBF8cssnUk=; b=CCJvv6Y5c7fAgyvGtZj0ij71Wl
	Uo2dJf4gYLP2BmquGLfrdeD7QmpTSdDpqSkovl/8oRDhuBNoE/mXr8Tr6qaSidpkjVR82bSV//zk9
	T+fHx3aXVKxpMUJxMoQ+5HFEasVkerq1j0/majHww6bbj0marnoeCJdW/ktVVhzgWy+xEANTkCGyc
	xIJWJpSYTmENwo7FDo8cWTvuhSFe/OznXgxH+S7PIuEVbKxe+YkvSaccoDvvXyiXivwYyaHv4Gvjn
	cdRAOnhL7RZZrqvZnqJB+0HK3fHNaf9u8DgEJHHDKyCxtzd5J7iMgWLppQ8mA+RgeCsGZC1/eWKSj
	Oj2GkKEQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1taZlB-00000001AIZ-0JDA;
	Wed, 22 Jan 2025 12:23:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4A6C0300599; Wed, 22 Jan 2025 13:23:04 +0100 (CET)
Date: Wed, 22 Jan 2025 13:23:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: Re: [PATCH v4 02/39] task_work: Fix TWA_NMI_CURRENT race with
 __schedule()
Message-ID: <20250122122304.GM7145@noisy.programming.kicks-ass.net>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <ad5fb696fbcd276c0902dbb94baa75fb79a6e1e2.1737511963.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad5fb696fbcd276c0902dbb94baa75fb79a6e1e2.1737511963.git.jpoimboe@kernel.org>

On Tue, Jan 21, 2025 at 06:30:54PM -0800, Josh Poimboeuf wrote:

> @@ -109,11 +126,6 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
>  	case TWA_SIGNAL_NO_IPI:
>  		__set_notify_signal(task);
>  		break;
> -#ifdef CONFIG_IRQ_WORK
> -	case TWA_NMI_CURRENT:
> -		irq_work_queue(this_cpu_ptr(&irq_work_NMI_resume));
> -		break;
> -#endif
>  	default:
>  		WARN_ON_ONCE(1);
>  		break;

Shouldn't this go to in the previous patch?
