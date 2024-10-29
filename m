Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910821DF728;
	Tue, 29 Oct 2024 13:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730207706; cv=none; b=tYLUicHRus3gFhWMmh7aSWVwqsiVLG4LHVNLgZGU0LhxpulrRsCIOqCFpe3VWHPbDvsSCNx7KxWvuMYQBaj+ZM7F9IX0LFG4CUzC/K8NgD7+p93O3RYK2F/px4R7Z3wUqTWXu9yC+myQeYBAujnEVNPkMOV96mu3zVa2KVLtQ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730207706; c=relaxed/simple;
	bh=kuJ3Fjcda1RNw1fiCyB9tDv/hfqeoLtXDMQNwY+yTSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgRBVo04Qcv4K9Pavrymm6AzICZa/jEjeAxj47uAPM18L23gWQZrJqw3eIe8DKFg6BoAyBYi6GdUZeULeRKfSzyPOAxrH/T+VKLOD+eB5F5MjgWLJoVsByA+XypdjqFL2HE+bp+7EBbf7F9WyhNnG0VcqrPbG/8xvz+apulDtZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Nrk5SqpO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Nrk5SqpO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DT7jeS7FiqKOMIwmZQjpdQKO9v8dB1eyq3lRzQ6nn5g=; b=Nrk5SqpO+K+YuQlAKs09zJvY3v
	ddtLQRMCv1ErYoMP+r908jjSceZTgNwGjGm5xiuvt4Vn070bPTuChIpPhBEQqbu8LYRIRURbD/EP1
	PJHPyTg15uqrRb2UvKeargvSsuILGrveAwgd+ASxMIFk/dkrRlbVcYq7iFWNMetkNR6sTYMM6A2+J
	PaSyDU57J3wktZg3EuQUGkuej2m1ust4GEkMm48i3Tz/g6PH7YbJkP894RJsS+0Zwyy5RLAvaPOOR
	vwoVlpMhl/NVo/EKp9sFMtXHeVj+37StCf0l4KfnalUU20d8qOBpdoew3uweAph3eNNJr6CNfg3kY
	nujb0hRA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t5m3Z-00000009jHJ-2ujf;
	Tue, 29 Oct 2024 13:14:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E59AF30073F; Tue, 29 Oct 2024 14:14:45 +0100 (CET)
Date: Tue, 29 Oct 2024 14:14:45 +0100
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
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 10/19] unwind/x86: Enable
 CONFIG_HAVE_UNWIND_USER_SFRAME
Message-ID: <20241029131445.GX14555@noisy.programming.kicks-ass.net>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <b7edac5073e55a11e051a86857b2a0fe159047ca.1730150953.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7edac5073e55a11e051a86857b2a0fe159047ca.1730150953.git.jpoimboe@kernel.org>

On Mon, Oct 28, 2024 at 02:47:37PM -0700, Josh Poimboeuf wrote:
> Binutils 2.41 supports generating sframe v2 for x86_64.  It works well
> in testing so enable it.

There is no sframe for 32bit?
