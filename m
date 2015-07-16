From: Paul Clarke <pc@us.ibm.com>
Subject: Re: perf annotate with sample counts
Date: Thu, 16 Jul 2015 07:44:20 -0500
Message-ID: <55A7A724.8010506@us.ibm.com>
References: <55A70107.3030106@us.ibm.com> <55A76492.8030203@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:47983 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680AbbGPMo0 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 16 Jul 2015 08:44:26 -0400
Received: from /spool/local
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-perf-users@vger.kernel.org> from <pc@us.ibm.com>;
	Thu, 16 Jul 2015 06:44:25 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
	by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 403091FF002E
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2015 06:35:32 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t6GChY1o54067208
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2015 05:43:34 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t6GCiLtI029590
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2015 06:44:21 -0600
In-Reply-To: <55A76492.8030203@suse.cz>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: =?windows-1252?Q?Martin_Li=9Aka?= <mliska@suse.cz>, linux-perf-users@vger.kernel.org

On 07/16/2015 03:00 AM, Martin Li=9Aka wrote:
> On 07/16/2015 02:55 AM, Paul Clarke wrote:
>> Is there a way to get perf annotate to display sample counts instead=
 of, or in addition to, percentages?
>>
>> The percentages seem relative to the function, which isn't as helpfu=
l in a global context.

> I think you are exactly looking for: https://lkml.org/lkml/2015/6/19/=
742, which
> I implemented couple of weeks ago :)

Near-perfect timing, I guess!  Thanks, Martin!

Do you have any sample output?  I don't see any in that thread.

Isn't this function analogous to perf report's "-n, --show-nr-samples"=20
option?  For consistency and usability, would it not be better to use=20
those options instead of "--show-total-period" ?

Thanks again!
PC
