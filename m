Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793718644;
	b=kY0VCxE013xB7j3Eq1cTJRiuJTVHLwJAv0Z2Pk3m6OQ8TsMD9cMGzy+z8Jn7+NQAe8gN
	 CaYxTRL7+qsB4bqTdvqdN4AnnWgd2XxxFx0bCp+ldg7ylQoVjKbaLRroeNnZY7u/01ijq
	 KDQdKXRR/0NBFNke6RemM2jIt3UO2UY/cYjSE+5FJSbcCXO18bHALY4OC4CqCW61e0/aA
	 hF+Z/70+RqCGxVEQGrV6cffDobWmVI7L5nUSnQwxbJW38ro+2esJSMp/RdbEU78rU5UUd
	 L03jHI6+T0dovqhVdKdT1sSOy8uAxgSELMTRsOzuJLtr9HbMqlq5oSbg0r69W/tyznQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718644;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Stat-Signature:
	 X-Spam-Status:X-Rspamd-Server:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=ESkAEuuc6yy51dqWmu+sKhO9bwkMv1/8Gydhfy53QWQ=;
	b=vI7Jx/IaOMYkqvjpb8YdMNhS/6JAJwKr1QsNXDpMDy1+w4iBzlDmvQy5trdaUyszKsjX
	 iVSUAY4K5c289VoDrOcXLAUpCKlaMUKBBD5noX2hvSIFPZ18dly2CkrC2tGPqD+405TQD
	 eIPMRcHThKzZCxDU3NjAIdaIs/1K6lKryiys6y+F8Q6r+Ed0jvsXZlUtrtCsybexwbjBT
	 MtkJdBti8NBZrBhRREwpJMw5FPLI5HoMXNbiUWHI/rWlTh8dUCG0DRtsVSP5YaoQ3xN8A
	 LGjw58Z/tA0QHJxan7lEBjiLeoUVD0qdot34hWeE3tPdUBDFSvunQpxIP+GditRdBXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=vgIXlRYX;
	arc=none smtp.remote-ip=216.40.44.12
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1666F606D2DA;
	Tue,  3 Nov 2026 15:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1666F606D2DA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=vgIXlRYX
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id BB1FFA047C;
	Tue,  3 Nov 2026 15:10:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 80A5B30;
	Tue,  3 Nov 2026 15:10:35 +0000 (UTC)
Date: Tue, 3 Nov 2026 10:10:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Paolo Bertinetti <paolobertinetti200f4@proton.me>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, James
 Clark <james.clark@linaro.org>, Kan Liang <kan.liang@linux.intel.com>, Leo
 Yan <leo.yan@arm.com>, Francesco Nigro <nigro.fra@gmail.com>, Sumanth
 Korikkar <sumanthk@linux.ibm.com>, linux-perf-users@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
Subject: Re: [PATCH 0/2] perf: Fix PERF_EVENT_IOC_REFRESH for tracepoints
 and breakpoints
Message-ID: <20261103101034.75f5bb0f@gandalf.local.home>
In-Reply-To: <20261103131138.765683-1-paolobertinetti200f4@proton.me>
References: <20261103131138.765683-1-paolobertinetti200f4@proton.me>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 80A5B30
X-Stat-Signature: u1mhwxim99k5uhjipj1oif11qk1hhbbm
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/lxSyrX1gU2HgudnYaeKf4tSHeqyO5JcE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=ESkAEuuc6yy51dqWmu+sKhO9bwkMv1/8Gydhfy53QWQ=; b=vgIXlRYXqd26A4OEK4CWvjySd7mR6lI47OqAj87iJoNj70UOViW1elyhCSjbgQQnEO1CuspSC+iHNvDmcmJRzm5HSh3fwxB0vGIT7HwuToBu+KPox/tKzHpjrELtSR9+vthP8XlPmWE23fYkTTjcrZ1PIdNkKCbMjEyg0Ln3r0M=
X-HE-Tag: 1793718635-427110
X-HE-Meta: U2FsdGVkX18rKnbTyAE96elUkva/DyDa9fDxY7tpAh+us0eWVDzJjLuxGjRVgLMUvOr+Q/i5hSU6zMPLOQXf1Vxw46bdrSPgXIWjS6SI0MVjJAu6U2yQewrYzIOr8nDavVBYKXhNBSBWvR9jtpr7NbYgpK2/tkE2HUIQIYHtEaR2cLT1OnoR8EB2/gtCXHVo2jq9i9B4m7q3rsJDMDBdi2BDE5xUNppHfFx6wdtasXMZZPBmL4wY8BTpn+ZjKFG1vfFT5vQGQHKUAqa0nMrXREBjuFQ2J/MkYBDCl5+swRuuizqwPgV2Xmve1P1JUGUlUQm2oeawvLDC6ohtV7DvBkIjgFDUGOr+X3tuOI8wxkJMJlarIKwLzQ==

On Tue, 03 Nov 2026 13:11:41 +0000
Paolo Bertinetti <paolobertinetti200f4@proton.me> wrote:

> This series went out twice by mistake. Please ignore this copy and
> reply to the first one:
> 
> https://lore.kernel.org/r/20261103130732.764081-1-paolobertinetti200f4@proton.me/
> 
> Sorry for the noise.

Yet this one has the cover letter whereas the other one does not :-/

-- Steve

