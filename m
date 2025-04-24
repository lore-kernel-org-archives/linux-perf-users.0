Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AA928E61F;
	Thu, 24 Apr 2025 18:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745519961; cv=none; b=K39ntadxBvj+vBDRhOsvUg0y7NjcCZWqHVInDS30l3b4LmtaOkX6qtmhwJ24LAVmyukPePBTlJd/UfnFdgULu7vlSbMgeLuvsZdLqjGvlBs/dLIJH192/SoBjApgQdXB14VmI9zZfvYk4rJLPMrWcwuNgiQ0Hs1FOKgwc0mlQrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745519961; c=relaxed/simple;
	bh=8EFa74gJjElQXa/T6HU4B7Pn6amPRC6SkNqCeKJS5lI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TBpdSFCY1Q0VNwUGXI23aDsHv7vSR+lG1IKDPCC7QlYWZBNepMrEHqQIzKrOUCdJXNq5QewF9OI4yiLHvHC+SJOFh+TD/R5Pz5mBpz1RYP//tsPJvTxvIJxDxndB8rwRqQv1PrhAYbc+5oN1lG1a03BoaNtbybPPISKJG0sM8a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1092C4CEE3;
	Thu, 24 Apr 2025 18:39:17 +0000 (UTC)
Date: Thu, 24 Apr 2025 14:41:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Indu Bhagat
 <indu.bhagat@oracle.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian
 Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, Mark
 Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org, Jordan Rome
 <jordalgo@meta.com>, Sam James <sam@gentoo.org>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, Jens Remus <jremus@linux.ibm.com>, Florian
 Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>, Weinan Liu
 <wnliu@google.com>, Blake Jones <blakejones@google.com>, Beau Belgrave
 <beaub@linux.microsoft.com>, "Jose E. Marchesi" <jemarch@gnu.org>
Subject: Re: [PATCH v5 00/17] perf: Deferred unwinding of user space stack
 traces
Message-ID: <20250424144113.7edf18fc@gandalf.local.home>
In-Reply-To: <CANiq72kG5-qZ2TopNx_AxYoB65XP7vHaNiUv4jh+w6MCrAnfbA@mail.gmail.com>
References: <20250424162529.686762589@goodmis.org>
	<20250424130421.53877e58@gandalf.local.home>
	<CANiq72kG5-qZ2TopNx_AxYoB65XP7vHaNiUv4jh+w6MCrAnfbA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Apr 2025 20:32:10 +0200
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> On Thu, Apr 24, 2025 at 7:02=E2=80=AFPM Steven Rostedt <rostedt@goodmis.o=
rg> wrote:
> >
> > Lovely, gmail doesn't like my email :-p =20
>=20
> Yeah, I had a moment ago 3 of your emails in my spam, so it seems it
> flagged them also for those getting it from a list.

Probably because I use kernel.org as my mail server but my address is
"rostedt@goodmis.org". Maybe I'll need to post patches as
rostedt@kernel.org :-p

-- Steve
