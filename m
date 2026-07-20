Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F2842B311;
	Mon, 20 Jul 2026 14:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557493; cv=none; b=Lo0jOvNtZq4iTYzYb6rdWmJm/B5NGWdMK1+7p8YpXkrFjpk47p8yluxMHJ9zPCf6wzEzHA0MSeSLfLSnW4MiHcs3L+fQKyd1mek51g1GAv8TLefhScuKB7b33axUdFZ7TflCHkBMiwRYYQwFuhop9Fvm2IGrdayC58QDx3jRfPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557493; c=relaxed/simple;
	bh=nJHwqodpka2gGhMWW0JBRL/YXJ6Yzeqj2mf9Le3yEYY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LneOMYgXgciO2h2/WB2bnOGUYSBqY98dyJvb3exYwAII4MMHkkQiEqGay7hXQp9ErgueqN4Mc/C1rIcdJXpczcfJi+UDcqEc3yUbtsv6zmyAM8D2N6n2z5ShOT+3alkL4W4jtTuhyBHtJFTr8MBHpIX598FFAjNxLbk4qBJSWis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsSNjfz8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsSNjfz8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E511F000E9;
	Mon, 20 Jul 2026 14:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784557491;
	bh=+lLIgvF7isoDrIHYELuREN+HQBBazSvKwi4llieRlTQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MsSNjfz8CPauPsBrPPnzqyS1VH+0A9UWJqD7L1iF6tyvhzIb/jz0baKBESIVJBGAD
	 yptYErPNFkTEiv0NdMvO6OcIg7IJ8kzHiPKuGQMRkehMENptSLMNpYMTmpBCkRuAXZ
	 9ASr0FigbTdA1CfMWNObYA/kf94fLgIzufv+lYB0EoAGQKwtXGbEXBCn0ugYp2Nt7G
	 kukqroRNQPge15mi5ncw1pgZeRWzNZ04jQrEQlAVNxKM5niBfG/6oLIFIJXZSEoSyI
	 KlNCqryhTp0XO/qH+/ZRt50xw0Lo9EBzpFREwzl+X+lRolgr8XacgXrs+csUvxZvUh
	 pwiNxH60a3Q8w==
Date: Mon, 20 Jul 2026 23:24:42 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Borislav Petkov <bp@alien8.de>, Jinchao Wang <wangjinchao600@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Jinchao Wang
 <wangjinchao600@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, David Hildenbrand
 <david@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox
 <willy@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, Randy Dunlap
 <rdunlap@infradead.org>, Alexander Potapenko <glider@google.com>, Marco
 Elver <elver@google.com>, Mike Rapoport <rppt@kernel.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH v2 00/13] mm/kwatch: dynamic hardware watchpoints
 for hunting memory corruption
Message-Id: <20260720232442.3e6b0e70c6939541b8362e05@kernel.org>
In-Reply-To: <20260717181004.GBalpv_MOaAflgFxgh@fat_crate.local>
References: <20260717125023.1895892-1-wangjinchao600@gmail.com>
	<91f3486b-3b85-4b43-b099-0a5325643352@intel.com>
	<20260717181004.GBalpv_MOaAflgFxgh@fat_crate.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jul 2026 11:10:04 -0700
Borislav Petkov <bp@alien8.de> wrote:

> On Fri, Jul 17, 2026 at 06:41:49AM -0700, Dave Hansen wrote:
> > On 7/17/26 05:50, Jinchao Wang wrote:
> > >  24 files changed, 2115 insertions(+), 63 deletions(-)
> > Reading this, I wonder how many kernel debugging features we need. I
> > don't even think we have a centralized list of them. They all just live
> > in their own silos.
> > 
> > This one really seems like a super specialized tool. It has to be
> > enabled at compile time and specifically aimed at a specific function.
> > 
> > Maybe this should live off on the side for a while. If folks end up
> > actually needing it, they can point their friendly LLM over to its tree.
> 
> Right, and in my mbox right under this mail thread there's a
> 
> https://lore.kernel.org/all/178429796992.157981.3393977217853767915.stgit@devnote2/
> 
> which Masami has been blasting almost every day this week which contains two
> of the patches from this set here...

Sorry about that. I tried to fix the reviewed comment from Sashiko,
but I should wait for someone's comment.

> 
> Looks to me like folks need to sit down and agree on strategy first.

Yeah, I need to talk with Jinchao.

Like kprobe, wprobe itself integrates watchpoint functionality into
the tracing subsystem. Jinchao, I would like to ask you to redesign
the kwatch tool based on fprobe and wprobe events in user space?
I think that could reduce redundant efforts on the similar feature.

Using fprobe entry and exit event trigger, we can make a Function-
scoped watch window. Also, since fprobe and wprobe are having BTF
typecast support, you can access to the members of data structures
more naturally.

If you are interested, I would be open to having you handle the
development of the necessary features for wprobe.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
