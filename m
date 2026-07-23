Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6BC29408;
	Thu, 23 Jul 2026 00:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784765121; cv=none; b=PYEv9QYXvZ21AMAOZ6OLDzBDsK51w/JUk4OCC+yIXNfTLNfZwCdPY10oUW/DtnFCNzOYrckvVwG4Z9kHWEmCj13WFFzYoSqRM6gYwGQ1rvT8lbbt3boCyXJXSMXJ+uMjcXNLbqVqrsAwI+H0Tym0rxEZ1Mz7oZNkNv4Lrt14+cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784765121; c=relaxed/simple;
	bh=ODmOs3ql59doMX2LLbQGHzR/0R/3iWA9I+z34aQiHZA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XU3M3EkWnWRg14fe33g7Qy151R2fXRcUFFuo6cgBxzl60o+9IUKlCbS4j/xlrGYd/8pgBxzncpbCcgKM7npzIOvzvOU58ePUe4mC/b5GInEVmhGxjnvARVL8KTVRx005xk7yRx4THLT0ncaT3sDcZrGQZ6UeBriiYoX8KorXk/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QttpmbDm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QttpmbDm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE6B1F000E9;
	Thu, 23 Jul 2026 00:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784765120;
	bh=cERcVi3l194vR2K7MPvUZ59VryqFLMg43o/10bMmISM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QttpmbDmFm3XT7advN73O+eWorj1Ah46zEsaAUHvor3l+aSKENGVnf8JVCdfRJMoC
	 UtILpVt6UfIYIJXf/mi8iq+Geg1cQwTn7RAO82o10FnFichBdWbjjPcQu/nuEYnDw3
	 J9nPPAZuGX9RDBc4b/IjDypVrNUKXfd/dbOugDl50C/rH+2ey51sYFijTgfyPqp1EF
	 J5i/WT8GDkNXkeZxffEoCJiV19FVq+XBCrTfmMPuRYUSdWm2J4uStkirxgsmga1tmE
	 sY7TbKMmaarKpQLKirwlyrmklQal0pzhh7tj4avo7ifK5m9QezOMgb/JWh+fB+G02a
	 wOisoMdBcnkYQ==
Date: Thu, 23 Jul 2026 09:05:11 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra
 <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
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
Message-Id: <20260723090511.bd1547ef01b8702a0449c887@kernel.org>
In-Reply-To: <0565e7d4-fb0f-4b84-a20c-0c73ac964b51@gmail.com>
References: <20260717125023.1895892-1-wangjinchao600@gmail.com>
	<91f3486b-3b85-4b43-b099-0a5325643352@intel.com>
	<20260717181004.GBalpv_MOaAflgFxgh@fat_crate.local>
	<20260720232442.3e6b0e70c6939541b8362e05@kernel.org>
	<0565e7d4-fb0f-4b84-a20c-0c73ac964b51@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jul 2026 08:36:01 -0400
Jinchao Wang <wangjinchao600@gmail.com> wrote:

> On 7/20/2026 10:24 AM, Masami Hiramatsu (Google) wrote:
> > On Fri, 17 Jul 2026 11:10:04 -0700
> > Borislav Petkov <bp@alien8.de> wrote:
> 
> >> Looks to me like folks need to sit down and agree on strategy first.
> > 
> > Yeah, I need to talk with Jinchao.
> > 
> > Like kprobe, wprobe itself integrates watchpoint functionality into
> > the tracing subsystem. Jinchao, I would like to ask you to redesign
> > the kwatch tool based on fprobe and wprobe events in user space?
> > I think that could reduce redundant efforts on the similar feature.
> > 
> > Using fprobe entry and exit event trigger, we can make a Function-
> > scoped watch window. Also, since fprobe and wprobe are having BTF
> > typecast support, you can access to the members of data structures
> > more naturally.
> > 
> > If you are interested, I would be open to having you handle the
> > development of the necessary features for wprobe.
> > 
> > Thank you,
> > 
> Thank you, Boris and Masami.
> 
> Boris is right that we should agree on the overall strategy before
> moving either series forward, especially since they share the low-level
> HWBP work. Masami is also right that fprobe and wprobe provide a more
> appropriate foundation than introducing KWatch as another standalone
> debugging tool.

Agreed. I just sent v10 because v9 lacked base-commit and Sashiko did
not reviewed. (so it just add a trigger-side BTF support which was
dropped in v9).
Think of v10 as the complete set of ideas we wanted to implement
with this wprobe.

> 
> After reconsidering the design, I will stop the standalone KWatch
> series. Instead, I would like to work with Masami on extending wprobe
> to support the function-scoped dynamic-watchpoint use cases that
> motivated KWatch.

Thanks Jinchao, I appreciate to work with you on this project.

> 
> Masami, thank you for being open to having me develop the necessary
> wprobe features. I am interested in taking that direction.

OK, please share your thoughts on watchpoint usage in the kernel.

Basically, I will fix the points raised in the review, but please
let me know if you have any other suggestions.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
