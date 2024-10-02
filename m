Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBFE1D1F74;
	Wed,  2 Oct 2024 14:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877906; cv=none; b=YCv7p0LkQpBZ9RTi4yuK4vsWV1SEq1APCh0ZypY1t4+YNJ8kym8HAmN161u82ICPrL6XPRyaSyL3ys8UenmE9j8pjHNrJjC/DAfGWUJqXtkHFxU+FNbKy+0oM2XVSk+hi311rD47ehMgrIpvKuqLfwvPtRqcZDeCIZ+a5i9csuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877906; c=relaxed/simple;
	bh=j984np+KRBWrWHNzTQAWx31zguXBZe97/TU0Er74eXY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DPbHE9eTJr8g1rzlpWvKoLPHUdQeHNs/x1rm3Q1DNR8sx0t8VmhENAbNYmX6PuDEwdGTVc1M9CGcxe6cwXtljmlXVwMpmQ7ONln6NER680FqyYd2GlhnUm0X+XSyjNL/0OXP7H4jB5GjgRrbnv+umNA3Ie3/02b2tsc13pWPZHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD6FC4CEC2;
	Wed,  2 Oct 2024 14:05:03 +0000 (UTC)
Date: Wed, 2 Oct 2024 10:05:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Florian Weimer <fweimer@redhat.com>
Cc: Indu Bhagat <indu.bhagat@oracle.com>, Josh Poimboeuf
 <jpoimboe@kernel.org>, x86@kernel.org, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, Mark Rutland
 <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian
 Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, Mark
 Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org, Jordan Rome
 <jordalgo@meta.com>, Sam James <sam@gentoo.org>
Subject: Re: [PATCH v2 03/11] unwind: Introduce SFrame user space unwinding
Message-ID: <20241002100555.0b269e16@gandalf.local.home>
In-Reply-To: <87frpegboy.fsf@oldenburg.str.redhat.com>
References: <cover.1726268190.git.jpoimboe@kernel.org>
	<ca2e603ae3dcfa3e836162ed8c301fd4d9fd4058.1726268190.git.jpoimboe@kernel.org>
	<20240914072358.4afad691@rorschach.local.home>
	<d2e7a4aa-2fd3-4b6f-b6e4-66b11e89d6ae@oracle.com>
	<20241001143624.08291d00@gandalf.local.home>
	<87frpegboy.fsf@oldenburg.str.redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 02 Oct 2024 10:18:21 +0200
Florian Weimer <fweimer@redhat.com> wrote:
> 
> I don't quite understand, sorry.
> 
> Doing a binary search on an unordered table fails to find some entries
> that could be discovered by a linear scan.  But an attacker could just
> as well use an incomplete table from the start.  So assuming an ordered
> table seems rather unlikely to introduce additional problems.  (Given
> the lack of a formal threat model, it's impossible to make more precise
> claims in either direction.)

Basically, the idea is if anything is out of place, scrap the entire
process. An unordered table can give unpredictable results, that could be
used latter as a gadget. If the kernel expects a sorted table and it ends
up not being sorted, it should automatically flag it as corrupt and stop
all processing.

The kernel doesn't need to scan the entire table each time to see if it is
sorted, that would kill the point of it being sorted in the first place.
But it can check that the values merge towards a correct answer. All it
needs to do is keep track of the current highest and lowest values, and if
it finds something outside that range, it should abort immediately.

The effort needed to validate is very low, so it should be done.

-- Steve

