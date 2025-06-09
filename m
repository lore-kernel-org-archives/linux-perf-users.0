Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2701CF7AF;
	Mon,  9 Jun 2025 20:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749500015; cv=none; b=JWZq3CIV31GPpvE+sjPdiYrWV1Xm7wc4mx0Qj/SkfjhjswHQh9L6/3RYTxLq1WbuB2xvSq1y59zCB5yJtQ/2ADMvm3tfSxGbhf/RnL0QduG63CyISuhu0sEsZTTC/ad7GvbO7jpRoB8nV11JqRuq9VUsOmGbyTE/+dhI24p5WK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749500015; c=relaxed/simple;
	bh=B+KKJw1mRV5eKyf8P3m5+SOLbQ1coDY0gwypLgQNMC8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XFfMLCB156Uih8NDayOIdXgYuiwXIW28xrBHkdd5FkS1GIuWZKfRFPuL6kLE/1JqsFmW+QAutXxhUcKAzrXpWdOIzkm96cUNZUsvvGq+vpVN9QpdV3aZVYrMLwMjWK+bhLNE6Qp2PtNNa30uKEUt3Twcd56rFT3kLaflxqqqk3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 0BB678022B;
	Mon,  9 Jun 2025 20:13:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id D6C1C20026;
	Mon,  9 Jun 2025 20:13:25 +0000 (UTC)
Date: Mon, 9 Jun 2025 16:14:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Shivank Garg <shivankg@amd.com>, mhiramat@kernel.org, oleg@redhat.com,
 peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, david@redhat.com,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [RFC] mm: use folio_expected_ref_count() helper for reference
 counting
Message-ID: <20250609161454.27122eb4@gandalf.local.home>
In-Reply-To: <aEc7JG-OL2fp075j@casper.infradead.org>
References: <20250609170806.447302-2-shivankg@amd.com>
	<aEc0MNj9JNXbLHmw@casper.infradead.org>
	<E40B36E2-1D0E-4769-B155-0175A06DE3AB@goodmis.org>
	<aEc7JG-OL2fp075j@casper.infradead.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D6C1C20026
X-Stat-Signature: m8h6bcy535xytnunifrds675jimjbr3x
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/kJ8UB1vD94YuNV8XjvktY0cPUQseZ4mw=
X-HE-Tag: 1749500005-938963
X-HE-Meta: U2FsdGVkX1/AbnxVbfcKCr7R6XcbF+NIATcgnSZMqeSoBZ8tgnjmm580xehAFo1U66DT7y1URDoJxSnyr8Qlf62mu6jBBImbCRwlr0MNscNf+Hj6CqxRMCN0GzwKttDu7pUlJJbLA7ZxWr+cix70+sg0E5OZQJ5ldrwLMducYMV4wYZ/lGCG/7ww17qqnxgB4h/HvU0WIAkKxsxnTNG67UynRvV8XJt3cdsNFB29lBpkqzdJZVLvHa5/TnK8N88Tz4XMIdnomHicXdG6pAwLWz+HMQxBuMC+jjpalt6eZjcc5orXSNT50Xy9/wLZZKKvq952wSzt65Y1rRZVwFxNoUAVyCsr7b5IMh8SsfcpbKIjAwUHwmNlXPhlMNO7hQ+c

On Mon, 9 Jun 2025 20:51:00 +0100
Matthew Wilcox <willy@infradead.org> wrote:

> On Mon, Jun 09, 2025 at 03:31:40PM -0400, Steven Rostedt wrote:
> > 
> > 
> > On June 9, 2025 3:21:20 PM EDT, Matthew Wilcox <willy@infradead.org> wrote:  
> > >On Mon, Jun 09, 2025 at 05:08:07PM +0000, Shivank Garg wrote:  
> > >> Replace open-coded folio reference count calculations with the
> > >> folio_expected_ref_count() helper to improve code maintainability
> > >> and reduce duplication.  
> > >
> > >If it needs this much additional commentary, perhaps it's not actually
> > >clearer?  
> > 
> > I don't know. I tend to over explain as I rather make it totally
> > obvious what is happening. I wouldn't say excessive commentary is
> > necessarily a sign that it's not clearer.  
> 
> That was a Socratic question, not for you to answer.
> 
> My opinion is that the extra commentary is obfuscatory and should be
> removed.


Ah, sorry, your response wasn't clear ;-)

-- Steve

