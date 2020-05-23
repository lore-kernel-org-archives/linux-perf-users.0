From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v3] perf record: Use an eventfd to wakeup when done
Date: Sat, 23 May 2020 06:34:56 -0700
Message-ID: <87a71y93lr.fsf@linux.intel.com>
References: <20200508145624.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid>
        <20200513122012.v3.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200513122012.v3.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid>
        (Anand K. Mistry's message of "Wed, 13 May 2020 12:20:23 +1000")
Sender: linux-kernel-owner@vger.kernel.org
To: Anand K Mistry <amistry@google.com>
Cc: linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Anand K Mistry <amistry@google.com> writes:
>  	}
>  
> +	done_fd = eventfd(0, EFD_NONBLOCK);

This will make perf depend on a recent glibc or other library
that implements eventfd. Wouldn't surprise me if some kind
of build time check is needed for this to pass all of Arnaldo's
built tests.


-Andi
