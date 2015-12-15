From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 3/9] perf test: new testsuite: perf annotate tests
Date: Tue, 15 Dec 2015 13:03:58 +0100
Message-ID: <20151215120358.GD5074@krava.brq.redhat.com>
References: <1449514394.24573.253.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60225 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965096AbbLOMEA (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 15 Dec 2015 07:04:00 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id CA7F6C0B9338
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Dec 2015 12:04:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1449514394.24573.253.camel@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Michael Petlan <mpetlan@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Mon, Dec 07, 2015 at 07:53:14PM +0100, Michael Petlan wrote:
> This commit adds tests for perf annotate tool.
> 
> The structure of the base_something dirs is the following:
> 
> base_something/
> 	settings.sh
> 		- a script mentioned to be sourced within the tests
> 	setup.sh
> 		- if present, necessary for setup of the subset
> 	test_*.sh
> 		- various tests of the subset
> 	cleanup.sh
> 		- a cleanup script that should remove logs, etc.
> 
> All the tests should be stand-alone.  So if needed, it is enough to
> cd to the proper base_directory and run the test.  Sometimes, setup
> is needed to be run first.
> 
> Example:
> 
> cd testsuite/base_annotate
> ./setup.sh
> ./test_basic.sh

hum, would it be better to allow running separate tests via
perf test suite like:

  $ perf test suite base_annotate

you'd need pass argv,argc into tests functions,
which shouldn't be big deal

jirka
