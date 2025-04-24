Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3A828EB;
	Thu, 24 Apr 2025 17:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745514150; cv=none; b=jnexB3BEgwt9KKvPYLDCU1qyp1aiupLlSxZOY7zAAUFsIUNAYtzcl3ysCJpIBUpzGlZ1SSTB3/hz1XLVwirMYidyko95AnwzhTn+RAZ5U98AS9jhxsjal2p1DAtfCmzUtz76MN0RfDJ7UtFjRdBhdKLn4KkmgMvMCjehwXnoQ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745514150; c=relaxed/simple;
	bh=CNxp6Z1MB30uiRFp/qSo/T5IhvHzwVejCc6n9G/dfBw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EDZkHZ1BrrVDgz6pA22eKoGlDBOCiw0utef4GN3XWnM+arMAMeD4dQXdA7oBsgj+QWlX4/AoDhI9gEyS78NggJkaj0TDhdcGeT9O5xPiqjDxY4/3BND/idZbTVUm7sC5V/c2bx2yNQIZtgEI/6SovjUPciFfHbRyqTouSPGQrno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F7AC4CEE3;
	Thu, 24 Apr 2025 17:02:26 +0000 (UTC)
Date: Thu, 24 Apr 2025 13:04:21 -0400
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
 E. Marchesi" <jemarch@gnu.org>
Subject: Re: [PATCH v5 00/17] perf: Deferred unwinding of user space stack
 traces
Message-ID: <20250424130421.53877e58@gandalf.local.home>
In-Reply-To: <20250424162529.686762589@goodmis.org>
References: <20250424162529.686762589@goodmis.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Lovely, gmail doesn't like my email :-p

-- Steve

--------
This is the mail system at host dfw.source.kernel.org.

I'm sorry to have to inform you that your message could not
be delivered to one or more recipients. It's attached below.

For further assistance, please send mail to postmaster.

If you do so, please include this problem report. You can
delete your own text from the attached returned message.

                   The mail system

<olsajiri@gmail.com>: host gmail-smtp-in.l.google.com[142.251.116.27] said:
    550-5.7.1 [139.178.84.217      12] Gmail has detected that this message is
    550-5.7.1 likely unsolicited mail. To reduce the amount of spam sent to
    Gmail, 550-5.7.1 this message has been blocked. For more information, go to
    550 5.7.1  https://support.google.com/mail/?p=UnsolicitedMessageError
    46e09a7af769-7304f39134fsi989826a34.281 - gsmtp (in reply to end of DATA
    command)

<arnaldo.melo@gmail.com>: host gmail-smtp-in.l.google.com[142.251.116.27] said:
    550-5.7.1 [139.178.84.217      12] Gmail has detected that this message is
    550-5.7.1 likely unsolicited mail. To reduce the amount of spam sent to
    Gmail, 550-5.7.1 this message has been blocked. For more information, go to
    550 5.7.1  https://support.google.com/mail/?p=UnsolicitedMessageError
    006d021491bc7-606469381a0si978892eaf.76 - gsmtp (in reply to end of DATA
    command)

<masami.hiramatsu@gmail.com>: host gmail-smtp-in.l.google.com[74.125.20.26]
    said: 550-5.7.1 [172.234.252.31      12] Gmail has detected that this
    message is 550-5.7.1 likely unsolicited mail. To reduce the amount of spam
    sent to Gmail, 550-5.7.1 this message has been blocked. For more
    information, go to 550 5.7.1
    https://support.google.com/mail/?p=UnsolicitedMessageError
    41be03b00d2f7-b15fb7b1684si2312872a12.593 - gsmtp (in reply to end of DATA
    command)

<mingo.kernel.org@gmail.com>: host gmail-smtp-in.l.google.com[74.125.20.26]
    said: 550-5.7.1 [172.234.252.31      12] Gmail has detected that this
    message is 550-5.7.1 likely unsolicited mail. To reduce the amount of spam
    sent to Gmail, 550-5.7.1 this message has been blocked. For more
    information, go to 550 5.7.1
    https://support.google.com/mail/?p=UnsolicitedMessageError
    d9443c01a7336-22db4fdfc07si22432465ad.243 - gsmtp (in reply to end of DATA
    command)
