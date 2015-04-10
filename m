From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 2/2] perf tools: Add a option 'remove' to perf-config and
 features which get or set a config variable.
Date: Fri, 10 Apr 2015 11:31:36 +0200
Message-ID: <20150410093136.GB31326@krava.brq.redhat.com>
References: <1428589591-22838-1-git-send-email-treeze.taeung@gmail.com>
 <1428589591-22838-2-git-send-email-treeze.taeung@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59804 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754014AbbDJJbp (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 10 Apr 2015 05:31:45 -0400
Content-Disposition: inline
In-Reply-To: <1428589591-22838-2-git-send-email-treeze.taeung@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Taeung Song <treeze.taeung@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, namhyung@kernel.org, linux-perf-users@vger.kernel.org

On Thu, Apr 09, 2015 at 11:26:31PM +0900, Taeung Song wrote:
> This patch consists of adding functions
> which get, set or remove a specific config variable.
> For the syntax examples,
> 
>     perf config [options] [section.subkey[=value]]
> 
>     display all perf config with default values
>     # perf config
>     or
>     # perf config -a | --all

so this is ^^^ what the previous patch does right?

> 
>     display a specific key(section.subkey) and value
>     # perf config report.queue
> 
>     set a specific key and value
>     # perf config report.queue=100M
> 
>     remove a specific key
>     # perf config -r | --remove report.queue

haven't checked the code but:

  [jolsa@krava perf]$ ./perf config krava=true
  The config variable does not contain a section: krava=true[jolsa@krava perf]$ 

missing '\n'

we can set anything now:
  [jolsa@krava perf]$ ./perf config krava.krava=true

the restriction for only known keys would need similar stuff like
for the '-a' option I asked in the previous email right?

jirka
