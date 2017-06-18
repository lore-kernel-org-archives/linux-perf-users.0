From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v2] RFC perf test 14 add platform dependency
Date: Mon, 19 Jun 2017 00:51:22 +0200
Message-ID: <20170618225122.GB13111@krava>
References: <20170613090937.72899-1-tmricht@linux.vnet.ibm.com>
 <20170616160817.GD3645@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57996 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752503AbdFRWv0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 18 Jun 2017 18:51:26 -0400
Content-Disposition: inline
In-Reply-To: <20170616160817.GD3645@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>, linux-perf-users@vger.kernel.org

On Fri, Jun 16, 2017 at 01:08:17PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jun 13, 2017 at 11:09:37AM +0200, Thomas Richter escreveu:
> > This is a proposal to add platform dependency into the
> > test case 14 (perf_event_attr). It is based on a suggestion from
> > Jiri Olsa.
> > Add a new optional attribute named 'machine' in the [config] section
> > of the test case file. It is a comma separated list of architecture
> > names this test can be executed on. For example:
> > 
> > machine = x86_64,alpha,ppc
> 
> Looks ok, Jiri?

sorry on late response, I'll look on it shortly

jirka
