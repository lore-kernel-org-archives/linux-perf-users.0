From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 1/2] perf script: allow extended console debug output
Date: Mon, 22 Oct 2018 12:09:15 -0300
Message-ID: <20181022150915.GJ3849@kernel.org>
References: <20181021191424.16183-1-milian.wolff@kdab.com>
 <20181022094033.GF2452@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181022094033.GF2452@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Milian Wolff <milian.wolff@kdab.com>, jolsa@kernel.org, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Mon, Oct 22, 2018 at 11:40:33AM +0200, Jiri Olsa escreveu:
> On Sun, Oct 21, 2018 at 09:14:23PM +0200, Milian Wolff wrote:
> > The script tool isn't using a browser, yet use_browser
> > wasn't set explicitly to zero. This in turn lead to confusing
> > output such as:
> > 
> > ```
> > $ perf script -vvv ...
> > ...
> > overlapping maps in /home/milian/foobar (disable tui for more info)
> > ...
> > ```
> > 
> > Explicitly set use_browser to 0 now, which gives us the extended
> > debug information now in perf script as expected.
> > 
> > Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo
