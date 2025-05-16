Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2159B46BF;
	Fri, 16 May 2025 22:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747435431; cv=none; b=SrzGitZiApj0whiwaNpxr4U5IQQQwz5TefiaB8MdmEQOEYblKQ4zQhjt78WHVmTnbT+6eWuayMIuRNRLeq1ZMqamf589jTXe9kBUmFOJefc7HutDWWOoRWKfL4MN2emYyauB9u/HKoHgFGfP4lB6AnQEYk5OXWuBV91ygHGVaMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747435431; c=relaxed/simple;
	bh=PCHcCgQCeojwufgffgqmZUHU4L7xOtj6HmqydT7FEnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D+Z3T73eOE+aDFgkjCkJqqoOIhak/UER61KwK/QmzYsN1nzCcd1Yv77g48usmGz/hDGvUXfKa4W9j92pilo/wH5PADAD9AI8duvkmWlSPkfnoIklIF37qG/UvMXPMpW1jWs02/M1rEM91VjQpLB/MPeuQOFZppdCGxxkdxwldmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D40C4CEE4;
	Fri, 16 May 2025 22:43:49 +0000 (UTC)
Date: Fri, 16 May 2025 18:43:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>,
 linux390-list@tuxmaker.boeblingen.de.ibm.com, sumanthk@linux.ibm.com,
 hca@linux.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com, Alexander
 Egorenkov <egorenar@linux.ibm.com>, linux-perf-users@vger.kernel.org, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf ftrace: Use process/session specific trace
 settings
Message-ID: <20250516184347.32c0454a@batman.local.home>
In-Reply-To: <aCeNhagT1CFny8r5@x1>
References: <20250516131023.357458-1-tmricht@linux.ibm.com>
	<aCeJcsJnbi7jfVdK@x1>
	<aCeNhagT1CFny8r5@x1>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 May 2025 16:09:57 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Yeah, you can just call rmdir and be done with it :-)

Yes. Removing an instance should reset everything about it before it
removes it. It disables events and sets the current tracer to "nop"
(stopping function tracing and such if it was present).

If there's a file open, then the rmdir should fail with -EBUSY.

-- Steve
