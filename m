Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0489D218AB0;
	Thu, 24 Apr 2025 20:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745526383; cv=none; b=gq0VJgWaxVjl6SRcOufYtB52aNswIEqepB7HLSUSY4RzmucrJql+d0jkpYauAipO4ZUeIrb7tMUmzRuCKtbbBPgJAovGXYP+yKVdSBHGjXLMtOnhqnFxkyFO+Xjax1vzxM2RW2AjLZAZtuwl+JoJDVhTfWXTZGwHeXBchMB/1iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745526383; c=relaxed/simple;
	bh=hmDxhIisNrDvigquYIooT5JRBpNhKGslwGGVnqE0sRo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h/Pei47qx516j5r7DJ8j4QbPxuCh9SAbCnYwzCnzKtQ0xf6efqlAJXCNGT/IiONUX5Oos77QzQotWkY82ND7BWY6vg0sQR4xUO5Eyv0oRYvuDc60kWarhv02L1FL3Q4NClIEB3oMI2O4vlLkiU8m3NFa8QLKQh7dkYRAp4dJ4wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559A1C4CEE3;
	Thu, 24 Apr 2025 20:26:19 +0000 (UTC)
Date: Thu, 24 Apr 2025 16:28:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, x86@kernel.org, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
 <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>, Sam
 James <sam@gentoo.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jens
 Remus <jremus@linux.ibm.com>, Florian Weimer <fweimer@redhat.com>, Andy
 Lutomirski <luto@kernel.org>, Weinan Liu <wnliu@google.com>, Blake Jones
 <blakejones@google.com>, Beau Belgrave <beaub@linux.microsoft.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Alexander Aring <aahringo@redhat.com>
Subject: Re: [PATCH v5 00/12] unwind_deferred: Implement sframe handling
Message-ID: <20250424162815.5d091b01@gandalf.local.home>
In-Reply-To: <20250424201511.921245242@goodmis.org>
References: <20250424201511.921245242@goodmis.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Apr 2025 16:15:11 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Hopefully someone can help me and work on this series ;-)

To make this easier, I applied all the series to one of my git branches and
pushed it to my personal repo:

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git

  branch: tip/sframe

-- Steve
