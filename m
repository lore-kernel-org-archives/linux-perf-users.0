Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EB83DB332;
	Tue,  1 Sep 2026 14:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273462; cv=none; b=el28OkIdmU4+HaoMGlCANwVSKrkkdDN6OCoawGiieA9JD21qg3gzbjukQttN7kX2xwoTUrI0UYU6C4vostP6Oue+QonOWwtOLhaZtKd3YOgc+/4nqddGvqR+u1n+LfJjnt8JMfmlK4TY8z+zK3+rFfbvt66jF9qZz+LAIjAoH7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273462; c=relaxed/simple;
	bh=v3wZJuDMDY6TSDIDONh2k6AtxL5ulmJGOmoHhLMcpwk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=duMYy8cQJd/pVTyTcm8z48ddNGcxEAesdMC+BQ6FMC+IEu+B6TTmE1HXmlP0n+qWptyAc0Etqs7m4RA1w8tcJ5JojmXjqej2B7jVOqEZOzWiQ+De9/dI1pgxgYEoO0kq+L96m3SO9FpLaOSFwr45/ax8f1DGK2H7/Z7/1X8MdxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=pF5ztuKj; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="pF5ztuKj"
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id CCE731C1FFC;
	Tue,  1 Sep 2026 14:37:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 9AE8832;
	Tue,  1 Sep 2026 14:37:21 +0000 (UTC)
Date: Tue, 1 Sep 2026 10:38:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, Jinchao Wang <wangjinchao600@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 3/3] tracing/probes: Fix code indent in
 get_bitoffset_of_field()
Message-ID: <20260901103820.2107bd39@gandalf.local.home>
In-Reply-To: <178827252027.123716.7095571176291547259.stgit@devnote2>
References: <178827248631.123716.2627172171811720261.stgit@devnote2>
	<178827252027.123716.7095571176291547259.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 19y4b9qhgdcgswwg4t5st45u8etsext7
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 9AE8832
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/iXbsiAH6pXVzSyFhCzaeWlIPa3DYWPjM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=yQDGO02vuRqXUkUjS+l5m4mq9vTXgkzRMx38IXIK0CY=; b=pF5ztuKjJB/8NEc+aYO5YPitCcMMu1Mozjclog5zStB/1FXmHuKvxWqQuKn0rg3IdISr+Uih6XaiHVOntU4HKmtneNGRSLdwIapBb0YDI4O1ZBwDW0mhmUPKcrqdm//ubf4G2W2lEKfIivpP6Qk0NeLAPxVyOZju1BWejSDNI4Y=
X-HE-Tag: 1788273441-787153
X-HE-Meta: U2FsdGVkX18UoaDCe/a3Z7bNfaIKcrS0dsbkS5g/02YOo6heimae2XurKyEyYCQFUlasfinFdp69LETmDJzD9qhqhotWxsUWenmXm7Lzu1QtYSdgVwW+XnZqLpUYybrNjhez07DOSjuti4a3VELjWLZxYMlo7boLj128oQAqOQTRka4hjO2YiqlFmDaTJqQGdyBeOnaTd8YbHEXFr/r/A+qh/RQKzx6vcSZ9wMaT01kJKP0LRYqEk3CRqhl7WmA9g9ZyRSwIQNqQUVqZEteUgDoslszmq1uVTKEa10YOCPYOZvtjv0ofuGwkcE7wF9IgMUEI14AulcJ+i7jMORcwHEVRRgxoF7c1dFtRkC3JM5AQ1cYxWraS8RCJ6mBRu2IAcO/d6iISuzFvEaai8x62gA==

On Tue,  1 Sep 2026 23:22:00 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Fix code block indentation introduced by commit f21834524025
> ("tracing/probes: Support field specifier option for typecast").
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve

