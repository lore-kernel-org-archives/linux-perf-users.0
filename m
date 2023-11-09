Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5006C36B0F
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Nov 2023 19:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B0BC433C7;
	Thu,  9 Nov 2023 19:49:53 +0000 (UTC)
Date: Thu, 9 Nov 2023 14:49:56 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Indu Bhagat <indu.bhagat@oracle.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, x86@kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian
 Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, Mark
 Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org
Subject: Re: [PATCH RFC 09/10] unwind: Introduce SFrame user space unwinding
Message-ID: <20231109144956.0c20fd98@gandalf.local.home>
In-Reply-To: <20231109193759.6wugcdpucoilnncl@treble>
References: <cover.1699487758.git.jpoimboe@kernel.org>
	<09460e60dd1c2f8ea1abb8d9188195db699ce76f.1699487758.git.jpoimboe@kernel.org>
	<24e46e1c-e9fa-4d44-97f2-068bda6e54b4@oracle.com>
	<20231109193759.6wugcdpucoilnncl@treble>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Nov 2023 11:37:59 -0800
Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> > The structure SFrame FDE in SFRAME_VERSION_1 was unaligned on-disk.  We
> > fixed that in SFRAME_VERSION_2 (Binutils 2.41) by adding some padding as you
> > have already noted. For x86_64, its not an issue though, yes.  
> 
> Agreed.  I actually had v2 implemented but then realized my binutils was
> older so I changed to v1 for testing.  But yeah, we can make v2 the
> minimum.

Cool, my test box has binutils 2.41, so it should be good to go ;-)

-- Steve
