From: hsultan@thefroid.net
Subject: Stability of KProbe (specifically KRetProbe) for production systems
Date: Wed, 24 Jun 2015 16:45:08 -0700
Message-ID: <47e93276a76a9be4ec26ec24d5faac4c@thefroid.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from hapkido.dreamhost.com ([66.33.216.122]:35893 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751842AbbFXXpL (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 24 Jun 2015 19:45:11 -0400
Received: from homiemail-a42.g.dreamhost.com (sub5.mail.dreamhost.com [208.113.200.129])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 1E609AA73B
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jun 2015 16:45:11 -0700 (PDT)
Received: from homiemail-a42.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a42.g.dreamhost.com (Postfix) with ESMTP id 1E79068C05B
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jun 2015 16:45:09 -0700 (PDT)
Received: from webmail.thefroid.net (caiajhbihbdd.dreamhost.com [208.97.187.133])
	(Authenticated sender: hsultan@thefroid.net)
	by homiemail-a42.g.dreamhost.com (Postfix) with ESMTPA id 1B49B68C058
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jun 2015 16:45:09 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

I am curious to know what the stance is from people with deep expertise 
with KProbe regarding its stability for use on production systems 
(meaning, what are the chances of crashing a system by inserting kernel 
probes).

The main use I am looking at is intercepting a few (~8-10) system 
calls, and retrieving some specific data from the task_struct mainly.

Notably :
- Is KProbe today (in the latest distribs : Ubuntu 14.04 , RHEL 7, 
etc...) stable to the point it is perfectly ok to use KProbe to say 
redirect system calls and perform measurements on them on a system 
that's high value ?  This obviously assumes that whatever code I am 
inserting in the probe is safe and sound.


- Did stability evolve over recent times or has it been deemed stable 
for years ? I'm trying to figure out if there's some kind of cutoff 
date, where kernels released before that cutoff date should not be used 
with KProbe and those after are okay. Even a very blurry timeline is 
fine btw, I don't need a specific day of the year :)

I'm interested in both the insertion and removal of the probes. Are 
they both safe ?

Thanks,

Hassan
