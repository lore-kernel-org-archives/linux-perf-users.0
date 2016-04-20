From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Ability for classifying of measurements
Date: Wed, 20 Apr 2016 06:08:33 -0700
Message-ID: <87ega0whpq.fsf@tassilo.jf.intel.com>
References: <1461099117-21401-1-git-send-email-leonardo.boquillon@tallertechnologies.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:12256 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751638AbcDTNIf (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 20 Apr 2016 09:08:35 -0400
In-Reply-To: <1461099117-21401-1-git-send-email-leonardo.boquillon@tallertechnologies.com>
	(Leonardo Boquillon's message of "Tue, 19 Apr 2016 17:51:57 -0300")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Leonardo Boquillon <leonardo.boquillon@tallertechnologies.com>
Cc: linux-perf-users@vger.kernel.org, daniel.gutson@tallertechnologies.com

Leonardo Boquillon <leonardo.boquillon@tallertechnologies.com> writes:
>
> In no way we intend this patch to be committed; we just want to show the idea 
> and start a discussion instead, focusing on the idea first rather than on the 
> design & code.

That's good because the patch as written is a big security hole (and in
fact will not work on any systems with SMAP enabled)

The basic concept seems reasonable, although a single address may be
too inflexible.

Often the main request I hear is for a simple way for an application
to turn on/off profiling, and perhaps add markers to distinguish
phases. It many cases that may be good enough.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
