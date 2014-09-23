From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] modify error code when perf_session__new() fail.
Date: Tue, 23 Sep 2014 14:02:31 +0200
Message-ID: <20140923120231.GD2979@krava.brq.redhat.com>
References: <1411452737-28188-1-git-send-email-treeze.taeung@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1411452737-28188-1-git-send-email-treeze.taeung@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: taeung <treeze.taeung@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, namhyung@kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

hi,
subject should start with 'perf tools:'

On Tue, Sep 23, 2014 at 03:12:17PM +0900, taeung wrote:
> 	Because perf_session__new() could fail
> 	for more reasons than just ENOMEM,
> 	I modified error code(ENOMEM or EINVAL)
> 	into -1.

why the indent?

> 
> Signed-off-by: taeung <treeze.taeung@gmail.com>

the log message needs some love, but the patch looks ok

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
