Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3510447F799;
	Thu,  3 Sep 2026 17:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788456653; cv=none; b=GUFb/bAD2P8vQ6ZKRapfAlKc0HBtKx6vUVLlmHj/McOacqP+6t7vfjX+d6Jlt28wyAQjLIFFZuaIkmbBSG/ywQ/rnrw9gk43GAtnFBQuski0i5yNvYX6Y3/q+LmKeWjeMBI4TSAC7+GdFiRJMnjlb47UStTw6Eg530qUUGXEaoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788456653; c=relaxed/simple;
	bh=MgMZfjHtJWGskJ7iDZWmY8Oed8R/GMs4VyOX/TuiH1U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXDWUTA0UWLlqLKNmt3sml6ulvLuqMwzJuQRRJIiDRk5akh/VpVBdrYHhrLpdG+1fvw8U5ojdBVJhnfmrzXfoF8Ykbva4jkGJ2gGGAmEC3qNGl0DbksEJ+UDLDnTX1XkNSGPAQPFknVncdfQh4ZmOiI1k3NppLoPwzr59OVBw/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=qqcyYnkg; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="qqcyYnkg"
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 3D481A4684;
	Thu,  3 Sep 2026 17:30:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 362BB1B;
	Thu,  3 Sep 2026 17:30:43 +0000 (UTC)
Date: Thu, 3 Sep 2026 13:31:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Russell King <linux@armlinux.org.uk>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-perf-users@vger.kernel.org,
 loongarch@lists.linux.dev, Mark Rutland <mark.rutland@arm.com>, Ian Rogers
 <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, "Luis Claudio
 R. Goncalves" <lgoncalv@redhat.com>, Catalin Marinas
 <catalin.marinas@arm.com>, James Clark <james.clark@linaro.org>, Huacai
 Chen <chenhuacai@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Oleg
 Nesterov <oleg@redhat.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Waiman Long <longman@redhat.com>, WANG
 Xuerui <kernel@xen0n.name>, Will Deacon <will@kernel.org>, Clark Williams
 <clrkwllms@kernel.org>
Subject: Re: [PATCH v2] ARM, ARM64, LONGARCH: Delay HW BP notification to
 task_work()
Message-ID: <20260903133146.07095885@gandalf.local.home>
In-Reply-To: <apmknG55qFAn8EPf@shell.armlinux.org.uk>
References: <20260814085118.OPEA_Ssn@linutronix.de>
	<20260903160710.vVf4gEL2@linutronix.de>
	<apmknG55qFAn8EPf@shell.armlinux.org.uk>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: q5rtu1fiqy3jfjswxfikew81wiyencsm
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 362BB1B
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19SQN1/iG251VKiSvCm90J/LH6Jif8jlZI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=MgMZfjHtJWGskJ7iDZWmY8Oed8R/GMs4VyOX/TuiH1U=; b=qqcyYnkg3p5F+UTVr/cgexJ1tZY0fAWBiki/WGjHsZ4h16riO0oLZP/UfGe0xdxU3KW71p1uZSD7oYxxFDSgdWxLofSFJMJqQc/uaEYXNDRZWgh/UmAbFyYg8nP9CFLA5mBn8hJD5OJy3yIsgkoNMnzTnL7skByDfjwMvD2e0vM=
X-HE-Tag: 1788456643-677296
X-HE-Meta: U2FsdGVkX18UDoUfH7MFH18LwOE6g10qW7dTkby7HjdB9X7BAG5qm8DxHVQQTPdtxGKneSZa9RInj6HuOfgU1jrR8yX6yW3K7fnvEf1/MlRgMD8jOUBQx2YsgQNEjrBWUvVSNqdIiYbJjJkh1E2120a+kJoPNZZT/6uir5B8TTX2BRq8V1KcQNPBobM5W6B+YvVAD/4d87POi8pasBUVzpHtLQvIraki2FkTv9BVPzITzzujsbAHvurHpIl46Ow6Cp6gV9QxwlxCX/VatqdB+E3ir7R0pC9W2Vd/V6ov65gCFH6Ja9hHLtsOf44MNChOQq5BQmWAckwdYllkNqTRN9/3dNiQVT0GA4ajriVWf566cpaX5UWqBgeoslbvLntd

On Thu, 3 Sep 2026 17:47:24 +0100
Russell King <linux@armlinux.org.uk> wrote:

> What do you expect to happen with this? Which arch maintainer should
> apply this patch that affects three different independently maintained
> architectures?

Looks like the patch should be broken up into a 4 part series.

One to add the ARCH_NEED_PERF_HW_NOTIF code to the generic code.

Then one for each architecture to add the code needed to set that.

Then the architecture maintainers could ack their patch and the perf
maintainer can pull it all in.

-- Steve
