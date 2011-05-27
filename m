From: Vince Weaver <vweaver1@eecs.utk.edu>
Subject: perf_event validation tests
Date: Fri, 27 May 2011 17:53:41 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1105271752090.5485@cl320.eecs.utk.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from aspirin.dii.utk.edu ([160.36.0.81]:44925 "EHLO
	aspirin.dii.utk.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754478Ab1E0WF2 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 27 May 2011 18:05:28 -0400
Received: from cl320.eecs.utk.edu (cl320.eecs.utk.edu [160.36.58.11])
	by aspirin.dii.utk.edu (8.13.6/8.13.4) with ESMTP id p4RLrYrS026453
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Fri, 27 May 2011 17:53:34 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello

a while back it was mentioned it would be nice to have some perf_event 
validation tests.

I've posted some here:
   http://web.eecs.utk.edu/~vweaver1/projects/perf-events/validation.html

It's a mix of tests that test the perf_events interface.  They don't test 
the perf tool itself, but the kernel ABI.  Some people might still find 
them useful.  And if you have any tests to suggest or contribute, feel 
free to drop me an e-mail.

Vince
vweaver1@eecs.utk.edu
