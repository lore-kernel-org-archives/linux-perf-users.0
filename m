From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCHv2 1/3] perf report: Display s390 diagnostic counter sets
Date: Sun, 20 Jan 2019 19:18:14 +0100
Message-ID: <20190120181814.GB8591@krava>
References: <20190117093003.96287-1-tmricht@linux.ibm.com>
 <20190117093003.96287-2-tmricht@linux.ibm.com>
 <20190117140053.GJ11922@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190117140053.GJ11922@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On Thu, Jan 17, 2019 at 11:00:53AM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

> --- a/tools/perf/util/python-ext-sources
> +++ b/tools/perf/util/python-ext-sources
> @@ -25,6 +25,7 @@ util/parse-branch-options.c
>  util/rblist.c
>  util/counts.c
>  util/print_binary.c
> +util/s390-sample-raw.c
>  util/strlist.c
>  util/trace-event.c
>  ../lib/rbtree.c

hi,
this change breaks the python module:

  >>> import perf
  Traceback (most recent call last):
    File "<stdin>", line 1, in <module>
  ImportError: ./perf.so: undefined symbol: color_fprintf

changelog doesn't say anything about python related change

jirka
