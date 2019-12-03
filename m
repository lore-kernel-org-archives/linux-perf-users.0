From: Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 19/23] perf beauty: Add CLEAR_SIGHAND support for clone's
 flags arg
Date: Tue, 3 Dec 2019 16:41:07 +0100
Message-ID: <20191203154106.7kio25pcank6p2a3@wittgenstein>
References: <20191203135606.24902-1-acme@kernel.org>
 <20191203135606.24902-20-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191203135606.24902-20-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Adrian Reber <areber@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

On Tue, Dec 03, 2019 at 10:56:02AM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Add support for the recently added CLONE_CLEAR_SIGHAND flag.
> 
> This takes advantage of the copy of the uapi/linux/sched.h we have in
> tools/include, which allows us to build tools/perf in older systems and
> have the binary support printing that flag whenever that system gets its
> kernel updated to one where this feature is present.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Adrian Reber <areber@redhat.com>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org
> Link: https://lkml.kernel.org/n/tip-1vnz497ubtu5oz16ygdcul0e@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Thanks!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
