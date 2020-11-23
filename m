Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A302C2D0E4
	for <linux-perf-users@archiver.kernel.org>; Mon, 23 Nov 2020 05:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07E7E2071E
	for <linux-perf-users@archiver.kernel.org>; Mon, 23 Nov 2020 05:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgKWFrM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 23 Nov 2020 00:47:12 -0500
Received: from mga12.intel.com ([192.55.52.136]:6907 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbgKWFrM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 23 Nov 2020 00:47:12 -0500
IronPort-SDR: rObQ4AdAraEh25eVTIlI2lXbuyD4iwLG3JyTuCg3RBYw1VFu9WFAjZDuGLoEZXBNdirwigsky2
 xtvHfqXPd1jA==
X-IronPort-AV: E=McAfee;i="6000,8403,9813"; a="150967901"
X-IronPort-AV: E=Sophos;i="5.78,361,1599548400"; 
   d="y'?h'?c'?scan'208";a="150967901"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2020 21:47:11 -0800
IronPort-SDR: YSLZiFJ/xXqUbDqLmZ1IEPRro1vCQ34HT/CmdZvlQ1cV/j4vnpty2JrCdSjFyRIvrQ/5BCBdPg
 vLP1mbkoXY3A==
X-IronPort-AV: E=Sophos;i="5.78,361,1599548400"; 
   d="y'?h'?c'?scan'208";a="535983619"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2020 21:47:11 -0800
Date:   Sun, 22 Nov 2020 21:46:58 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 5/5] perf metric: Don't compute unused events.
Message-ID: <20201123054658.GF894261@tassilo.jf.intel.com>
References: <20201121031119.3554769-1-irogers@google.com>
 <20201121031119.3554769-6-irogers@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <20201121031119.3554769-6-irogers@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> +| expr '|' expr
> +{
> +	if (!compute_ids || (isfinite($1.val) && isfinite($3.val))) {
> +		assert($1.ids == NULL);
> +		assert($3.ids == NULL);
> +		$$.val = (long)$1.val | (long)$3.val;
> +		$$.ids = NULL;
> +	} else {
> +		/*
> +		 * LHS or RHS needs to be computed from event IDs, consequently
> +		 * so does this expression. Set val to NAN to show that the set
> +		 * of all values is possible, the events are the union of those
> +		 * on the LHS and RHS.
> +		 */
> +		$$.val = NAN;
> +		$$.ids = ids__union($1.ids, $3.ids);
> +	}


Sorry, still not a fan of the having this nan code all over. It's just ugly.

If you don't want to do the syntax change to still do it in one pass,
and given building an AST would be a little complicated.

The original parser I based this code on actually had a byte code version too
(see attachment). With that one the lazy evaluation could be done on the byte code
level. Originally I didn't include it because it wasn't really
needed for perf, but presumably if we want to do more complicated
things it might be useful. 

In theory it could speed up performance slightly when an expression needs
to be computed multiple times in interval mode.

-Andi

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="code.c"

#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

#include "code.h"
#include "sym.h"
#include "error.h"

static unsigned char *bufs;
static unsigned bufl;
static unsigned char *bufp;

static void overflow(void)
{
	yyerror("expression exceeds execution buffer");
}

void put_op(enum ops op)
{
	if (bufp >= bufs + bufl)
		overflow();
	*bufp++ = op;
}

void put_long(enum ops op, long arg)
{
	if (bufp + sizeof(long) + 1 >= bufs + bufl)
		overflow();
	*bufp++ = op;
	memcpy(bufp, &arg, sizeof(long));
	bufp += sizeof(long);
}

void put_ptr(enum ops op, void * arg)
{
	if (bufp + sizeof(void *) + 1 >= bufs + bufl)
		overflow();
	*bufp++ = op;
	memcpy(bufp, &arg, sizeof(void *));
	bufp += sizeof(void *);
}

void start_def(struct symbol *s)
{
	if (!s->undef)
		yyerror("symbol %s redefined", s->name);
}

void end_def(struct symbol *s)
{
	int len;

	put_op(OP_RET);
	len = bufp - bufs;
	s->code = malloc(len);
	memcpy(s->code, bufs, len);
	bufp = bufs;
	s->undef = 0;
}

static void execerror(char const *msg)
{
	fprintf(stderr, "expression execution error: %s\n", msg);
	exit(1);
}

#define STACKSIZE 16
#define CSTACKSIZE 16

long execute(unsigned char *bufp)
{
	static void *target[] = {
		[OP_END]    = &&end,
		[OP_EVENT]  = NULL,
		[OP_NUMBER] = &&number,
		[OP_PLUS]   = &&plus,
		[OP_MINUS]  = &&minus,
		[OP_MUL]    = &&mul,
		[OP_DIV]    = &&div,
		[OP_MOD]    = &&mod,
		[OP_NEGATE] = &&negate,
		[OP_CALL]   = &&call,
		[OP_RET]    = &&ret,
		[OP_XOR]    = &&xor,
		[OP_OR]     = &&or,
		[OP_NOT]    = &&not,
		[OP_AND]    = &&and,
		[OP_SHL]    = &&shl,
		[OP_SHR]    = &&shr,
	};
	long a, b;
	long stack[STACKSIZE];
	int stackp = 0;
	unsigned char *callstack[CSTACKSIZE];
	int callstackp = 0;

#define getop(x) memcpy(&(x), bufp, sizeof(x)); bufp += sizeof(x)
#define push(x)  stack[stackp++] = (x)
#define pop()    stack[--stackp]
#define next()   goto *target[(int)*bufp++]

	next();

number:
	if (stackp == STACKSIZE)
		execerror("expression stack overflow");
	getop(a);
	push(a);
	next();

#define OP(op) \
	b = pop();	\
	a = pop();	\
	push(a op b);	\
	next()

plus:	OP(+);
minus:	OP(-);
mul:	OP(*);

div:
	b = pop();
	if (b == 0)
		execerror("division by 0");
	a = pop();
	push(a / b);
	next();

mod:
	b = pop();
	if (b == 0)
		execerror("modulo by 0");
	a = pop();
	push(a % b);
	next();

negate:
	a = pop();
	push(-a);
	next();

and:	OP(&);
or:	OP(|);
xor:	OP(^);
shl:	OP(<<);
shr:	OP(>>);

not:
	a = pop();
	push(~a);
	next();

call:   {
		struct symbol *s;
		getop(s);
		if (callstackp == CSTACKSIZE)
			execerror("call stack overflow");
		callstack[callstackp++] = bufp;
		bufp = s->code;
		next();
	}

ret:
	bufp = callstack[--callstackp];
	next();

end:
	assert(bufp == bufs || stackp == 1);
	assert(callstackp == 0);
	return stack[0];
}

#undef next
#undef push
#undef pop
#undef getop

void code_init(unsigned char *buf, unsigned len)
{
	bufs = buf;
	bufp = buf;
	bufl = len;
}

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="code.h"


enum ops {
	OP_END,
	OP_EVENT,
	OP_NUMBER,
	OP_PLUS, OP_MINUS,
	OP_MUL, OP_DIV, OP_MOD,
	OP_NEGATE,
	OP_CALL, OP_RET,
	OP_OR, OP_AND, OP_XOR, OP_NOT,
	OP_SHL, OP_SHR,
};

struct symbol;
void put_op(enum ops op);
void put_long(enum ops op, long arg);
void put_ptr(enum ops op, void *arg);
void code_init(unsigned char *buf, unsigned bufl);
void start_def(struct symbol *s);
void end_def(struct symbol *s);
long execute(unsigned char *bufp);

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="expr.y"

%{
// notebook:
// need unsigned operators?
// don't exit on errors
// don't require expr after defs
// text description for defs
// hash
#include "sym.h"
#include "code.h"
#include "error.h"
%}

%union {
	long num;
	struct symbol *sym;
}

%token DEF
%token <num> EVENT // XXX own type
%token <num> NUMBER
%token <sym> SYMBOL
%left '|'
%left '^'
%left '&'
%left SHL SHR
%left '-' '+'
%left '*' '/' '%'
%left NEG NOT

%{
#include <stdio.h>
#include <string.h>
#include <assert.h>
#include <ctype.h>
#include <stdlib.h>
#include <stdarg.h>
#include <errno.h>

static int yylex(void);
static unsigned char buf[1024];
static char symname[128];
%}

%%

def_and_expr: def_list expr ;

def_list: def_list definition
	|
	;

definition: DEF SYMBOL { start_def($2); } '=' expr ';' { end_def($2); }
	;

expr:     EVENT			{ put_long(OP_EVENT, $1); }
	| NUMBER		{ put_long(OP_NUMBER, $1); }
	| SYMBOL		{ if ($1->undef) 
				     yyerror("undefined symbol %s", $1->name);
				  put_long(OP_CALL, (long)$1); }
	| expr '|' expr		{ put_op(OP_OR); }
	| expr '&' expr		{ put_op(OP_AND); }
	| expr '^' expr		{ put_op(OP_XOR); }
	| expr SHL expr		{ put_op(OP_SHL); }
	| expr SHR expr		{ put_op(OP_SHR); }
	| '~' expr %prec NOT	{ put_op(OP_NOT); }
	| expr '+' expr		{ put_op(OP_PLUS); }
	| expr '-' expr		{ put_op(OP_MINUS); }
	| expr '*' expr		{ put_op(OP_MUL); }
	| expr '/' expr		{ put_op(OP_DIV); }
	| expr '%' expr		{ put_op(OP_MOD); }
	| '-' expr %prec NEG	{ put_op(OP_NEGATE); }
	| '(' expr ')'
	;

%%

#define SYMHASHSZ 1
struct symbol *slist[SYMHASHSZ];

static int symhash(char *s)
{
	return 0; // XXX
}

static struct symbol *getsymbol(char *name)
{
	struct symbol *s;
	int h = symhash(name);
	for (s = slist[h]; s; s = s->next)
		if (!strcmp(s->name, name))
			return s;
	s = malloc(sizeof(struct symbol));
	s->name = strdup(name);
	s->undef = 1;
	s->next = slist[h];
	slist[h] = s;
	return s;
}

static long number(int c)
{
	char buf[32];
	char *endp;
	long num;
	int i;

	i = 0;
	do {
		if (i == sizeof buf - 1)
			yyerror("number too long");
		buf[i++] = c;
		c = getchar();
	} while (isdigit(c) || c == 'x');
	if (c != EOF)
		ungetc(c, stdin);
	buf[i++] = 0;
	errno = 0;
	num = strtol(buf, &endp, 0);
	if (errno == ERANGE)
		yyerror("number over/underflow");
	if (endp == buf)
		yyerror("cannot parse number");
	return num;
}

static int symbol(int c)
{
	int i = 0;

	do {
		if (i >= sizeof(symname))
			yyerror("symbol too long");
		symname[i++] = c;
		c = getchar();
	} while (isalpha(c) || isdigit(c) || c == '.' || c == '_');
	if (c != EOF)
		ungetc(c, stdin);
	symname[i] = 0;
	if (!strcasecmp(symname, "def"))
		return DEF;
	yylval.sym = getsymbol(symname);
	return SYMBOL;
}

static int yylex(void)
{
	int c, c1;

	for (;;) {
		c = getchar();
		if (c == EOF)
			return 0;
		switch (c) {
		case '\n':
			yylineno++;
			continue;
		case ' ': case '\t': case '\r':
			continue;
		case '0' ... '9':
			yylval.num = number(c);
			return NUMBER;
		case '+': case '-': case '*': case '/': case '%':
		case '(': case ')': case '=': case ';':
		case '^': case '&': case '|': case '~':
			return c;
		case '<':
		case '>':
			c1 = getchar();
			if (c1 == c)
				return c == '<' ? SHL : SHR;
			break;
		case 'A'...'Z':
		case 'a'...'z':
		case '_':
			return symbol(c);
		case '#':
			do {
				c = getchar();
			} while (c != '\n' && c != EOF);
			continue;
		}

		yyerror("unknown character '%c'", c);
	}
}

int main(void)
{
	code_init(buf, sizeof buf);
	yyparse();
	put_op(OP_END);
	printf("%ld\n", execute(buf));
	return 0;
}

--jI8keyz6grp/JLjh--
