From: Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 1/9] perf test: Adding an entry for the
 perftool-testsuite
Date: Tue, 29 Mar 2016 14:19:17 +0200 (CEST)
Message-ID: <alpine.LRH.2.20.1603290206080.7107@Rudolf-RHEL-7>
References: <cover.1458134357.git.mpetlan@redhat.com> <alpine.LRH.2.20.1603161450230.13911@Rudolf-RHEL-7> <20160327122447.GM4015@krava.sund.root.ku.dk>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37019 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751805AbcC2MTU (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 29 Mar 2016 08:19:20 -0400
In-Reply-To: <20160327122447.GM4015@krava.sund.root.ku.dk>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org

On Sun, 27 Mar 2016, Jiri Olsa wrote:
> On Wed, Mar 16, 2016 at 02:50:59PM +0100, Michael Petlan wrote:
>
> SNIP
>
>> +	ret = chdir("..");
>> +	ret = ret;
>
> hm? ;-)

That must be there, otherwise the compiler would complain about unused
variable 'ret'. When removing 'ret' at all, the compiler complains about
ignoring return value of 'chdir()'.

Well, ok, there could be something like:

if(!ret)
{
 		fprintf("FATAL: Cannot cd to ..\n");
 		return 1;
}

Do you think it is worth of being there instead?

>
> jirka
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
