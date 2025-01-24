Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39CB1CEEA4;
	Fri, 24 Jan 2025 17:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737740256; cv=none; b=a2auBCI2OtZ0/J5aala4FFkVW7wmqMSIWC4/qWerV/3bA96myfrz/31UXnUcrlbKmXZTMN9EUL1G414OtRF7DjurYUZHWqAfX/0K1ab8fY+2S7njQbQmsMdsfDAo8o4fBJiZlkex5I+qQcudZMdgb8tXAMz6IXa3SCdwZCxY6BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737740256; c=relaxed/simple;
	bh=i0HMNi06ZXg+QZAbjkjC1nzxDe71FCu6eaF5GcU+2Ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYoC09/yJB4CqgzSQqMzuujseXLpHhnur0ezOZMkL06mR0jXQfuULL3cfgAIq8JsX0tiCP6JSUoR+qPoMpcwAfmFrdxU87KuD1zwyFGtTGuuv5uP5OyAm0Lwt85AlYfrfa3ZdTclWZBHNnw+YgUt4/u3ya//SdjiQqCnDmynhwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsrnRGK+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsrnRGK+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C815EC4CED2;
	Fri, 24 Jan 2025 17:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737740256;
	bh=i0HMNi06ZXg+QZAbjkjC1nzxDe71FCu6eaF5GcU+2Ag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hsrnRGK+xOsqgTuDppY705rmRVH9kCzqPYIdIQtdecTcJf7FtSROExJmhW3lyM9IZ
	 M9P8Bto4fPxbUYrEiHR7YJn8KE+OeG7FLPF4gXAwiGCzo6kln1XYHmVECrCmK12fq2
	 32FzNRLEcp7Rq8hjawPB0SAkqsyFHA6Qdja2vAW+mrP3rw9oflSeGDWVYzBNBiuIE8
	 e3Pe8qevWqI6PlqUAQ0fbJj+aaT6dfvujhmmO5Z2y/BJ2aRxgw9FDIKFGt6nK81G5W
	 nB0Xg7HEsPNg6kIhv4m9E78AbsmJPF34oQgsYcY7MPlv+vPnEi9U3gcCdGcqGBGfwL
	 NOoxTdWk9y6fg==
Date: Fri, 24 Jan 2025 09:37:34 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf probe: Introduce --no-advice option when a new
 event is created
Message-ID: <Z5PP3vPpYOccGWIv@google.com>
References: <20241214193452.16627-1-atomlin@atomlin.com>
 <Z5Ld5irdG--_Efgl@google.com>
 <oqon532hz5nktpgilvpmvd5ywuasppbkfw2f6z5gjluyzo62ow@n7ynrou6uykm>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <oqon532hz5nktpgilvpmvd5ywuasppbkfw2f6z5gjluyzo62ow@n7ynrou6uykm>

On Fri, Jan 24, 2025 at 10:54:04AM +0000, Aaron Tomlin wrote:
> On Thu, Jan 23, 2025 at 04:25:10PM -0800, Namhyung Kim wrote:
> > Hello,
> 
> Hi Namhyung,
> 
> > Sorry for the late reply.
> 
> No problem at all.
> 
> > On Sat, Dec 14, 2024 at 07:34:52PM +0000, Aaron Tomlin wrote:
> > > This patch introduces a new option namely "--no-advice" to be used with
> > > the add command. Now one has the ability to avoid the generation of any
> > > advice when a new event is created. Thus making the output reasonable.
> > > For example:
> > > 
> > >   # perf probe --no-advice --add 'user_path_at%return return=$retval:s32'
> > >   Added new event:
> > >     probe:user_path_at__return (on user_path_at%return with return=$retval:s32)
> > >   #
> > 
> > Thanks for sending the patch but why do you care?  You can just ignore
> > the message.
> 
> I understand.
> 
> As a frequent and avid perf-probe user, I often only need to confirm the
> successful creation of a new event, ensuring its presence under
> /sys/kernel/debug/tracing/events/probes for subsequent use with Ftrace.
> The ability to suppress verbose output would be a valuable enhancement.
> 
> Please let me know your thoughts.

Sounds like you may want -q option to suppress all output and check the
exit code of the command.

Thanks,
Namhyung

