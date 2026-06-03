Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7EB37C930;
	Wed,  3 Jun 2026 10:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780483822; cv=none; b=gV68djut6s6nk8xz7ckG4q/HfJHO0YCPXLuUiMJH+rmAs39u3bDbsn81rQXYNXfzhLIRNkoihPRMfC47EeTWdp0yaeK1iM9oB1ZtgueJwsvnCFCoIEZcSZnlS4xw4i23+ttxZvhvtj7zYMMQA2b2pp6iOqS9yLuGa4GoEZtBADk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780483822; c=relaxed/simple;
	bh=rGdLobv2crwIaUMkGhzSUMfkwNH0pVONnO2583Iw0vk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aW09PzsQrZixYH40Zihvg1G3ct9J+tRWVPzTul2XBJi2BVGs4JeeWEfCaw9TyF4DeS1d7TGRqE2sdqgud+shvDU5avKSRMvTSWv23nDtS3sAWtHyOhygnFtdXapHrHjyQdDaBpasIJE2eIiFJBp+NAeVJ1LBmJN7WPygfAFTjrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=gtHKMp73; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gtHKMp73"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA4D02BCA;
	Wed,  3 Jun 2026 03:50:15 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54B9A3F632;
	Wed,  3 Jun 2026 03:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780483820; bh=rGdLobv2crwIaUMkGhzSUMfkwNH0pVONnO2583Iw0vk=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=gtHKMp73q4BSa0h99rIkiNIePRVj4k4jOw1jOnU9y4Ei9hKOUZDruqo0t7rqxkPxv
	 8qNf4TdQWjVQJ6G60IfbD/LPixZbazGjqJyIOO8GmW8kN4kHhiJIW+GoDQw6Hl3Qnn
	 vAV63g6ATZuFR/IRYNcNwIvvcEtu+ar30kFlodkM=
Date: Wed, 3 Jun 2026 11:50:18 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Amir Ayupov <aaupov@meta.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Paschalis Mpeis <Paschalis.Mpeis@arm.com>,
	coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 02/18] perf test: Add workload-ctl option
Message-ID: <20260603105018.GQ101133@e132581.arm.com>
References: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
 <20260602-james-cs-context-tracking-fix-v2-2-85b5ce6f55c6@linaro.org>
 <20260603104001.GP101133@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603104001.GP101133@e132581.arm.com>

On Wed, Jun 03, 2026 at 11:40:01AM +0100, Coresight ML wrote:
> On Tue, Jun 02, 2026 at 03:26:44PM +0100, James Clark wrote:
> 
> [...]
> 
> > --- a/tools/perf/Documentation/perf-test.txt
> > +++ b/tools/perf/Documentation/perf-test.txt
> > @@ -69,3 +69,9 @@ OPTIONS
> >  
> >  --list-workloads::
> >  	List the available workloads to use with -w/--workload.
> > +
> > +--workload-ctl=fifo:ctl-fifo[,ack-fifo]::
> > +	Write 'enable' to ctl-fifo before running the workload and 'disable'
> > +	before returning. If ack-fifo is provided, the workload runner waits for
> > +	an 'ack' response after each command. This scopes the recording to only
> > +	the workload if used with 'perf record -D 1 --control ...'.
> 
> This new option doesn't work on its own. I would spell out in explicit
> words that it needs to communicate with perf record session:
> 
>   "This option is used to communicate with a perf record session in
>   order to control the recording scope. When specifying this option,
>   the same FIFO path must be specified in the record session via:
> 
>     perf record -D 1 --control=fifo:ctl-fifo[,ack-fifo] ...

Correct typo: s/-D 1/-D -1/
